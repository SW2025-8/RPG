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

  # ★ クエスト達成
  def complete
    user = current_user

    # ===== 経験値獲得（ここが不足していた） =====
    user.add_exp(@quest.exp) if @quest.respond_to?(:exp)

    # ===== バトル進行 =====
    user.battle_position += 1

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
