class Public::ItemsController < ApplicationController
  def index
    @total_items = Item.all
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end

