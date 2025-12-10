# app/controllers/home_controller.rb

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    # 現在ログイン中ユーザーのクエストだけ取得
    @quests = current_user.quests.order(created_at: :asc)
  end
end
