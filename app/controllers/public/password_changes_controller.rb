class Public::PasswordChangesController < ApplicationController
  before_action :authenticate_customer!
  
  def edit
   @customer = current_customer
  end
   
  def update
   @customer = current_customer
   if @customer.update(customer_params)
    sign_in(@customer, bypass: true)
    redirect_to edit_public_profile_path, notice: '更新しました'
   else
    render :edit
   end
  end
    
  private
  
  def customer_params
   params.require(:customer).permit(:name, :email, :password, :password_confirmation, :image)
  end

end

