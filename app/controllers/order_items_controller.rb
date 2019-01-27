class OrderItemsController < ApplicationController
  def create
    @order = current_order
    order_item = @order.order_items.where(product_id: order_item_params[:product_id], order_id: @order.id).first

    if order_item
      sum = order_item.quantity + order_item_params[:quantity].to_i
      order_item.update(quantity: sum)
    else
      # @order_item = @order.items.create_with(order_item_params).find_or_create_by(product_id: order_item_params[:product_id], order_id: @order.id)
      @order_item = @order.order_items.new(order_item_params)
      @order.save
      session[:order_id] = @order.id
    end

  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items

  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items

  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
