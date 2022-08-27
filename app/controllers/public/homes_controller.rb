class Public::HomesController < ApplicationController
  def top
    # itemsを最新順から呼び出し
    @items=Item.all.order(created_at: :desc)
  end

  def about
  end
end
