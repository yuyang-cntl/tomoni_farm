class Farmer::StatisticsController < ApplicationController
  def index
    @monthly_sales = Order.group_by_month(:created_at, format: "%Y年%m月", time_zone: false).sum(:grand_total)
  end
end
