class QuestsController < ApplicationController
  before_action :set_quest, only: [:show, :edit, :update, :destroy, :complete]

  def index
    @quests = current_user.quests
  end

  def show
  end

  def new
    @quest = current_user.quests.new
  end

  def create
    @quest = current_user.quests.new(quest_params)
    if @quest.save
      redirect_to quests_path, notice: "クエストを作成しました！"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @quest.update(quest_params)
      redirect_to quests_path, notice: "クエストを更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @quest.destroy
    redirect_to quests_path, notice: "クエストを削除しました。"
  end

  # ★後で実装する complete アクションの土台（まだ中身は書かない）
  def complete
    current_user.gain_exp(@quest.exp_reward)
    @quest.destroy
    redirect_to quests_path, notice: "クエスト完了！EXP +#{@quest.exp_reward}"
  end


  def set_quest
    @quest = current_user.quests.find(params[:id])
  end

  def quest_params
    params.require(:quest).permit(:title, :description, :exp_reward)
  end
end
