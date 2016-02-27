class ItemsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @item = Item.create(item_params)

    Pusher['private-shopping-cart-'+@item.stream_id.to_s].trigger('client-new_item', {
      id: @item.id,
      contents: @item.contents,
      price: @item.price,
      quantity: @item.quantity,
      status: @item.status,
      imageurl: @item.imageurl,
      progress: @item.progress,
      stream_id: @item.stream_id,
      viewer_id: @item.viewer_id
    })

    respond_to :js
  end

  def destroy
    @item = Item.find(params[:id])

    Pusher['private-shopping-cart-'+@item.stream_id.to_s].trigger('client-delete_item', {
      id: @item.id
    })

    @item.destroy
    respond_to :js
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes(item_params)

    if @item.progress == 2
      Pusher['private-shopping-cart-'+@item.stream_id.to_s].trigger('client-cart_item', {
        id: @item.id,
        status: @item.status,
        progress: @item.progress,
        price: @item.price
      })
    elsif @item.progress == 3
      Pusher['private-shopping-cart-'+@item.stream_id.to_s].trigger('client-viewerpaidfor_item', {
        id: @item.id,
        status: @item.status,
        progress: @item.progress
      })
    else
    end
    respond_to :js
  end

  def mobileassociateditems
    @items = Item.where("stream_id = ?", params[:streamid])
    render json: @items
  end

  def item_params
    params.require(:item).permit(:contents, :price, :quantity,
    :status, :imageurl, :stream_id, :progress, :viewer_id, :order_id)
  end
end
