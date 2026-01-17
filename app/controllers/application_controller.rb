class ApplicationController < ActionController::Base
  before_action :record_login_log, if: :user_signed_in?
  before_action :apply_time_hp_damage_once, if: :user_signed_in?

  private

  def record_login_log
    today = Date.current
    return if current_user.login_logs.exists?(login_date: today)
    current_user.login_logs.create!(login_date: today)
  end

  # ★ 追加：HP減少は1リクエスト1回だけ
  def apply_time_hp_damage_once
    return if @hp_damage_applied
    current_user.apply_time_hp_damage!
    @hp_damage_applied = true
  end
end
