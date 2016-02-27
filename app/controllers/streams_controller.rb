class StreamsController < ApplicationController
  before_filter :authenticate_user!, except: [ :homepage, :index, :show, :mobileuserindex, :mobileallstreams ]

  def index
    if current_user == nil
      if (params[:lat] and params[:lng]) == nil
        redirect_to '/homepage'
      else
        @streams = Stream.where("progress = ?", 2).within(30, :origin => [params[:lat], params[:lng]])
      end
    else
      if current_user.lat == nil
        if (params[:lat] and params[:lng]) == nil
          redirect_to "/homepage"
        else
          current_user.lat = params[:lat]
          current_user.lng = params[:lng]
          res = Geokit::Geocoders::GoogleGeocoder.reverse_geocode params[:lat].to_s+","+params[:lng].to_s
          puts res.full_address
          if current_user.save
            @streams = Stream.where("progress = ?", 2).within(30, :origin => [current_user.lat, current_user.lng])
          else
            @streams = Stream.where("progress = ?", 2).within(30, :origin => [params[:lat], params[:lng]])
          end
        end
      else
        if (params[:lat] and params[:lng]) == nil
          @streams = Stream.where("progress = ?", 2).within(30, :origin => [current_user.lat, current_user.lng])
        else
          current_user.lat = params[:lat]
          current_user.lng = params[:lng]
          res = Geokit::Geocoders::GoogleGeocoder.reverse_geocode params[:lat].to_s+","+params[:lng].to_s
          current_user.city = res.city
          current_user.zipcode = res.zip
          current_user.state = res.state
          if current_user.save
            @streams = Stream.where("progress = ?", 2).within(30, :origin => [current_user.lat, current_user.lng])
          else
            @streams = Stream.where("progress = ?", 2).within(30, :origin => [params[:lat], params[:lng]])
          end
        end
      end
    end
  end

  def mobileuserindex
    if current_user == nil
      if (params[:lat] and params[:lng]) == nil
        render json: "no lat-long params given"
      else
        @streams = Stream.where("progress = ?", 2).within(30, :origin => [params[:lat], params[:lng]])
        render json: @streams
      end
    else
      if (params[:lat] and params[:lng]) == nil
        @streams = Stream.where("progress = ?", 2).within(30, :origin => [current_user.lat, current_user.lng])
        render json: @streams
      else
        current_user.lat = params[:lat]
        current_user.lng = params[:lng]
        res = Geokit::Geocoders::GoogleGeocoder.reverse_geocode params[:lat].to_s+","+params[:lng].to_s
        current_user.city = res.city
        current_user.zipcode = res.zip
        current_user.state = res.state
        if current_user.save
          @streams = Stream.where("progress = ?", 2).within(30, :origin => [current_user.lat, current_user.lng])
          render json: @streams
        else
          @streams = Stream.where("progress = ?", 2).within(30, :origin => [params[:lat], params[:lng]])
          render json: @streams
        end
      end
    end
  end

  def homepage
    @streams = Stream.where("progress = ?", 2).limit(8).order("RANDOM()")
  end

  def show
    @stream = Stream.find(params[:id])
    @message = Message.new
  end

  def mobileshow
    @stream = Stream.find(params[:id])
    render json: @stream
  end

  def mobileassociatedmessages
    @stream = Stream.find(params[:id])
    @messages = Message.where("stream_id = ?", @stream.id)
    render json: @messages
  end

  def create
    @stream = Stream.new(stream_params)

    if @stream.save
      stream_url = @stream.url.to_s()+@stream.id.to_s()
      puts stream_url
      @stream.url = stream_url
      if @stream.save
        render json: @stream
      else
        render json: "failed"
      end
    else
      render json: "failed"
    end
  end

  def edit
    @stream = Stream.find(params[:id])
  end

  def update
    @stream = Stream.find(params[:id])

    if @stream.update_attributes(stream_params)
      redirect_to show_stream_path(@stream.id), notice: "updated"
    else
      redirect_to streams_path, notice: "Something went wrong"
    end
  end

  def mobileupdate
    @stream = Stream.find(params[:id])

    if @stream.update_attributes(stream_params)

      if @stream.progress == 3
        Pusher['private-broadcast-'+@stream.id.to_s].trigger('client-timerstart', {
          timerlength: @stream.timerlength
        })
      elsif @stream.progress == 4
        @items = Item.where("progress != ? AND stream_id = ?", 3, @stream.id)
        @items.each do |item|
          Pusher['private-shopping-cart-'+item.stream_id.to_s].trigger('client-delete_item', {
            id: item.id
          })
          item.destroy
        end
      elsif @stream.progress == 5
        @items = Item.where("stream_id = ?", @stream.id)
        @items.update_all(:progress => 4)
        Pusher['private-broadcast-'+@stream.id.to_s].trigger('client-endstream', {
        })
      end

      render json: @stream
    else
      render json: @stream
    end
  end

  def destroy
    @stream = Stream.find(params[:id])
    @stream.destroy
    redirect_to streams_path, notice:"Your review has been deleted"
  end

  def mobilecardsindex
    cards = Stripe::Customer.retrieve(current_user.customertoken).sources.all(:object => "card")
    render json: cards
  end

  def mobileaddcard
    customer = Stripe::Customer.retrieve(current_user.customertoken)
    customer.sources.create({:source => params[:token]})
    render json: current_user
  end

  def mobileallstreams
    @streams = Stream.where("progress = ?", 2)
    render json: @streams
  end

  def stream_params
    params.require(:stream).permit(:url, :host_user_id, :number_of_watchers,
    :name, :description, :store, :lat, :lng, :thumbnail_url, :progress, :timerlength)
  end
end
