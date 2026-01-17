class InventoryController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_items = current_user.user_items.includes(:item)
  end

  def use
    user_item = current_user.user_items.find(params[:id])
    item = user_item.item
    user = current_user

    return redirect_to inventory_path, alert: "所持していません" if user_item.quantity <= 0

    # ★ 追加：ゲームオーバー中は復活の書のみ使用可
    if user.hp <= 0 && item.effect_type != "revive"
      return redirect_to inventory_path, alert: "ゲームオーバー中は復活の書のみ使用できます"
    end

    case item.effect_type
    when "heal_one"
      return redirect_to inventory_path, alert: "HPは満タンです" if user.hp >= User::MAX_HP
      user.hp = [user.hp + 1, User::MAX_HP].min

    when "heal_full"
      return redirect_to inventory_path, alert: "HPは満タンです" if user.hp >= User::MAX_HP
      user.hp = User::MAX_HP

    when "revive"
      return redirect_to inventory_path, alert: "今は使用できません" if user.hp > 0
      user.hp = User::MAX_HP

    else
      return redirect_to inventory_path, alert: "不正なアイテムです"
    end

    ActiveRecord::Base.transaction do
      user_item.quantity -= 1
      user.last_hp_ticked_at = Time.current

      user.save!
      user_item.save!

      user.item_logs.create!(
        item: item,
        action: "use"
      )
    end

    redirect_to root_path, notice: "#{item.name} を使用しました"
  end
end
