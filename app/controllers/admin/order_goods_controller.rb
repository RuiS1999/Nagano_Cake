class Admin::OrderGoodsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_good = OrderGood.find(params[:id])

    @order_good.update(order_good_params)
    @order = @order_good.order

    # 制作ステータスを「製作中(2)」→注文ステータスを「製作中(2)」
    if @order_good.making_status == "in_production"
      @order.update(order_status: 2)
    end

    # 注文個数と制作完了になっている個数が同じならば
    if @order.order_goods.count == @order.order_goods.where(making_status: 3).count
      @order.update(order_status: 3)
    end

    redirect_to request.referer
  end

  private

  def order_good_params
    params.require(:order_good).permit(:order_id, :making_status, :amount)
  end
end
