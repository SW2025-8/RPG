class UsersController < ApplicationController
  before_action :authenticate_user!

  # アバター選択画面
  def avatar
    @user = current_user

    # 内部値 → 表示名（日本語）
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

    # radio_button_tag を使っているので params[:avatar_type] で受け取る
    if @user.update(avatar_type: params[:avatar_type])
      redirect_to root_path, notice: "アバターを変更しました！"
    else
      render :avatar
    end
  end
end
