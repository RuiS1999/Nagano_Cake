class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @item_total_price = @order.order_goods.inject(0) { |sum, order_good| sum + order_good.sum_of_price }
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to request.referer

    if @order.order_status == "payment_confirmation"
      @order.order_goods.each do |order_good|
        order_good.update(making_status: 1)
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
