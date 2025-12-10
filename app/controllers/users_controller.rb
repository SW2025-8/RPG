class UsersController < ApplicationController
  before_action :authenticate_user!

  # マイページ
  def mypage
    @user = current_user
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
