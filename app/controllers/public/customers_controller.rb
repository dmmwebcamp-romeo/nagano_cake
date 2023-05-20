class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_mypage_path
    else
      redirect_to customers_information_edit_path
    end
  end

  def out
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "またのご利用をお待ちしております。"
    redirect_to root_path
  end


  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name)
  end

end
