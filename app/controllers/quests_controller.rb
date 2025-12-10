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

  def complete
    @quest.destroy
    redirect_to quests_path, notice: "クエスト達成！"
  end

  private

  def set_quest
    @quest = current_user.quests.find(params[:id])
  end

  # exp_reward を permit から外すのが今回の最重要ポイント
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
