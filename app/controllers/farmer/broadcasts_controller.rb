class Farmer::BroadcastsController < ApplicationController

  def new
    @templates = ::EmailTemplate.where(farmer_id: current_farmer.id)
  end

  def create
    service = FarmerBroadcastService.new(
      current_farmer,
      subject: params[:subject],
      body: params[:body]
    )
    service.call
    redirect_to farmer_dashboard_path, notice: "フォロワーにメールを送信しました"
  end
end
