class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_customer.notifications.order(created_at: :desc)
    @notifications.where(read: false).update_all(read: true)
  end

  def show
    @notification = current_customer.notifications.find(params[:id])
  end

  def update
    @notification = current_customer.notifications.find(params[:id])
    @notification.update(read: true)
    redirect_to public_notifications_path
  end

end
