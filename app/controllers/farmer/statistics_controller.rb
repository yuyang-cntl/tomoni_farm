class Farmer::StatisticsController < ApplicationController
  def index
    # 商品ごとの月別売上
    @stacked_sales = Item.all.map do |item|
      monthly_data = Order.where(item_id: item.id)
                          .group_by_month(:created_at, format: "%Y年%m月", time_zone: false)
                          .sum(:grand_total)
      {name: item.name, data: monthly_data}
    end
    @monthly_sales = Order.group_by_month(:created_at, format: "%Y年%m月", time_zone: false).sum(:grand_total)
    @item_sales = Order.joins(:item).group("name").sum(:grand_total)
    @yearly_sales = Order.group_by_year(:created_at, format: "%Y年", time_zone: false).sum(:grand_total)
    # 投稿に対するいいね数
    @stacked_likes = Post.joins(:diary).map do |post|
      next unless post.diary.present?
      like_count = post.likes.count
      post_date = post.created_at.strftime("%Y年%m月%d日")
      {
        name: post.title,
        data: { post_date => like_count},
        date: post_date,
        link: farmer_diary_post_path(post.diary, post)
      }
    end.compact
  end
end
