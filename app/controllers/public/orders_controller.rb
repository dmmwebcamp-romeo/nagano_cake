class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def confirmation
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @total_price = 0
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end
end
