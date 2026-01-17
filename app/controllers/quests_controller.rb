class QuestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quest, only: [:show, :edit, :update, :destroy, :complete]

  def index
    @quests = current_user.quests
              .order(Arel.sql("due_date IS NULL ASC"))
              .order(:due_date)
              .order(created_at: :asc)
  end

  def show
    # set_quest で @quest を取得するだけ
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
    user = current_user

    user.add_exp(@quest.exp_reward)

    coins =
      case @quest.difficulty
      when "初級"   then 1
      when "中級"   then 2
      when "上級"   then 3
      when "超上級" then 4
      else 0
      end
    user.coins += coins

    user.quest_logs.create!(
      title: @quest.title,
      exp: @quest.exp_reward
    )

    if user.hp > 0
      user.deal_damage_to_enemy!(@quest.exp_reward)
    end

    user.save!
    @quest.destroy

    redirect_to root_path, notice: "クエスト達成！ +#{coins}コイン"
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
      :difficulty,
      :exp_reward,
      :due_date
    )
  end
end
