class Farmer::BroadcastsController < ApplicationController

  def new
    @templates = ::EmailTemplate.where(farmer_id: current_farmer.id)
  end

  def create
    if params[:subject].blank? || params[:body].blank?
      flash[:alert] = "件名と本文は必須です"
      redirect_to new_farmer_broadcast_path and return
    end
    
    service = FarmerBroadcastService.new(
      current_farmer,
      subject: params[:subject],
      body: params[:body]
    )
    service.call
    redirect_to farmer_dashboard_path, notice: "フォロワーにメールを送信しました"
  end

end
