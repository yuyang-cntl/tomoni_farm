class Farmer::BroadcastLogsController < ApplicationController
  def index
    @broadcast_logs = current_farmer.broadcast_logs.order(sent_at: :desc)
  end

  def show
    @broadcast_logs = current_farmer.broadcast_logs.order(sent_at: :desc)
    @broadcast_log = @broadcast_logs.find(params[:id])
  end
end
