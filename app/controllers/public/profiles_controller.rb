class Public::ProfilesController < ApplicationController
  before_action :authenticate_customer!

  def edit
   @customer = current_customer
  end
  
  def show
   @customer = current_customer
  end

  def update
   @customer = current_customer
   if @customer.update(customer_params)
    sign_in(@customer, bypass: true)
    redirect_to public_profile_path, notice: '更新しました'
   else
    render :edit
   end
  end

  def confirm_destroy
    @customer = current_customer
   end

  def destroy
    current_customer.update!(is_active: false)
    sign_out current_customer
    redirect_to root_path, notice: "退会が完了しました。ご利用ありがとうございました。"
   end

   private

   def customer_params
    params.require(:customer).permit(
    :last_name, :first_name, :last_name_kana, :first_name_kana,
    :email, :password, :password_confirmation, :profile_image)
   end

end
