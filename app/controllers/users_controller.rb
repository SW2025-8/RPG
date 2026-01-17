class UsersController < ApplicationController
  before_action :authenticate_user!

  # マイページ
  def mypage
    @user = current_user

    # ▼ カレンダー用（ログインカレンダーと同等） ▼
    @month = params[:month] ? Date.parse(params[:month]) : Date.current
    @start_date = @month.beginning_of_month.beginning_of_week(:sunday)
    @end_date   = @month.end_of_month.end_of_week(:sunday)

    @login_dates = @user.login_logs.pluck(:created_at).map(&:to_date)
  end

  # アバター選択画面
  def avatar
    @user = current_user

    @avatar_options = {
      "warrior" => "戦士",
      "mage"    => "魔法使い",
      "priest"  => "僧侶",
      "thief"   => "盗賊"
    }
  end

  # アバター更新処理
  def update_avatar
    @user = current_user

    if @user.update(avatar_type: params[:avatar_type])
      redirect_to root_path, notice: "アバターを変更しました！"
    else
      render :avatar
    end
  end
end
