class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def create
    @order = Order.new(order_params)

    @items = Item.where("stream_id = ? AND viewer_id = ?", @order.stream_id, @order.viewer_id)
    total_pricebeforetax = 0
    @items.each do |item|
      total_pricebeforetax = total_pricebeforetax + (item.quantity * item.price)
    end

    total_pricebeforetax = total_pricebeforetax * 100
    total_pricebeforefees = total_pricebeforetax * 1.075
    total_totalprice = total_pricebeforefees * 1.1

    @order.taxrate = 0.075
    @order.pricebeforetax = total_pricebeforetax
    @order.pricebeforefees = total_pricebeforefees
    @order.totalprice = total_totalprice
    @order.save

    @items.update_all(:order_id => @order.id)

    render json: @order
  end

  def completeorder
    @order = Order.find(params[:id])
    @order.update_attributes(order_params)

    @user = User.find(@order.viewer_id)
    @stream = Stream.find(@order.stream_id)
    @streamer = User.find(@stream.host_user_id)

    @items = Item.where("order_id = ?", @order.id)
    @items.update_all(progress: 5)

    Stripe::Charge.create(
      :amount => @order.totalprice,
      :currency => "usd",
      :customer => @user.customertoken,
      :card => @order.cardcode,
      :description => "Pay For Order " + @order.id.to_s,
      :application_fee => (@order.totalprice - @order.pricebeforefees),
      :destination => @streamer.uid
    )
    render json: @order
  end

  def mobileassociatedordersanditems
    @orders = Order.where("stream_id = ?", params[:streamid])
    @items = Item.where("stream_id = ?", params[:streamid])

    render :json => {orders: @orders, items: @items}
  end

  def mobileusersordersanditems
    @orders = Order.where("viewer_id = ?", current_user.id)
    @items = Item.where("viewer_id = ?", current_user.id)

    render :json => {orders: @orders, items: @items}
  end

  def order_params
    params.require(:order).permit(:lat, :lng, :viewer_id,
    :stream_id, :taxrate, :pricebeforetax, :pricebeforefees, :totalprice, :cardcode,
    :is_delivered, :signitureurl)
  end
end
