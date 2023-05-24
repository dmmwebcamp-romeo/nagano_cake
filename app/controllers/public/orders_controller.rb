class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @addresses = current_customer.shipping_addresses
  end
  
  def confirm
    @order = Order.new(order_params)
    params[:order][:pay_option] = params[:order][:pay_option].to_i
    @order.postage = 800
    @cart_items = current_customer.cart_items

    if params[:order][:select_address] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      
    elsif params[:order][:select_address] == "1"
      @address = ShippingAddress.find(params[:order][:shipping_address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name
      
    else params[:order][:select_address] == "2"
    end
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    @order.save
    
    @cart_items = current_customer.cart_items
    
      @cart_items.each do |cart_item|
        @order_item = OrderItem.new
        @order_item.order_id = @order.id
        @order_item.item_id = cart_item.item_id
        @order_item.quantity = cart_item.quantity
        @order_item.price_tax = cart_item.item.price * cart_item.quantity * 1.1
        @order_item.save
      end
      
    redirect_to orders_complete_path 
    current_customer.cart_items.destroy_all
  end

  def complete
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def show
    @order = Order.find(params[:id]) 
  end
  
  private

  def order_params
    params.require(:order).permit(:post_code, :address, :name, :total_price, :pay_option)
  end

end