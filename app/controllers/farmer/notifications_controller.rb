class Farmer::NotificationsController < ApplicationController
  
  def index
    @notifications = current_farmer.notifications.order(created_at: :desc)
    @notifications.where(read: false).update_all(read: true)
  end

  def show
    @notification = current_farmer.notifications.find(params[:id])
  end

  def update
    @notification = current_farmer.notifications.find(params[:id])
    @notification.update(read: true)
    redirect_to farmer_notifications_path
  end
  
end
