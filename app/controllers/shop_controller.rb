class ShopController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.all.order(:price)
  end

  def buy
    item = Item.find(params[:item_id])
    user = current_user

    if user.coins < item.price
      return redirect_to shop_path, alert: "コインが足りません"
    end

    user_item = user.user_items.find_or_initialize_by(item: item)
    user_item.quantity ||= 0

    ActiveRecord::Base.transaction do
      user.coins -= item.price
      user_item.quantity += 1
      user.save!
      user_item.save!

      # ★ 購入ログ
      user.item_logs.create!(
        item: item,
        action: "buy"
      )
    end

    redirect_to shop_path, notice: "#{item.name} を購入しました"
  end
end
