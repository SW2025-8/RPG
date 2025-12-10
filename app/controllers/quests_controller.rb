class QuestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quest, only: [:edit, :update, :destroy, :complete]

  def index
    @quests = current_user.quests.order(created_at: :asc)
  end

  def new
    @quest = current_user.quests.new
  end

  def create
    @quest = current_user.quests.new(quest_params)

    if @quest.save
      redirect_to quests_path, notice: "クエストを追加しました！"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @quest.update(quest_params)
      redirect_to quests_path, notice: "更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @quest.destroy
    redirect_to quests_path, notice: "削除しました"
  end

  # ★ ここが今回の本番ロジック
  def complete
    user = current_user

    # 1. 敵の位置を1つ進める
    user.battle_position += 1

    # 2. ボスまで倒したら次のステージへ進む
    if user.battle_position > 5
      user.battle_stage += 1
      user.battle_position = 1
      user.stage_exp = 0
    end

    user.save!

    # クエスト達成したら削除
    @quest.destroy

    redirect_to root_path, notice: "クエスト達成！次の敵が出現した！"
  end

  private

  def set_quest
    @quest = current_user.quests.find(params[:id])
  end

  def quest_params
    params.require(:quest).permit(
      :title,
      :description,
      :category,
      :subcategory,
      :difficulty
    )
  end
end
