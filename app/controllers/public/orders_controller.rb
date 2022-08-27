class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @cart_items = CartItem.all
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.sum_of_price }+800
    @order.customer_id = current_customer.id
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
        @order_good = OrderGood.new
        @order_good.order_id = @order.id
        @order_good.item_id = cart_item.item_id
        @order_good.amount = cart_item.amount
        @order_good.price_in = cart_item.item.add_tax_price
        @order_good.save
        current_customer.cart_items.destroy_all
      end
      redirect_to orders_complete_path
    else
      redirect_to new_order_path
    end
  end

  def index
    @orders = Order.all
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @item_total_price = @order.order_goods.inject(0) { |sum, order_good| sum + order_good.sum_of_price }
  end

  def confirm
    @customer = Customer.find(current_customer.id)
    @cart_items = CartItem.all
    @order = Order.new(order_params)
    @item_total_price = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.sum_of_price }
    @total_price = @item_total_price + 800
    if params[:select_address] == 'radio0'
      @order.name = current_customer.full_name
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
    elsif params[:select_address] == 'radio1'
      @id = params[:order][:select_address].to_i
      @address = @customer.addresses.find(@id)
      @order.name = @address.name
      @order.postal_code = @address.postal_code
      @order.address = @address.address
    elsif params[:select_address] == 'radio2'
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :postage, :total_payment, :payment_method, :order_status)
  end


end
