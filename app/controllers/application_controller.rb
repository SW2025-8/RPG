class ApplicationController < ActionController::Base
  before_action :record_login_log, if: :user_signed_in?

  private

  def record_login_log
    today = Date.current

    return if current_user.login_logs.exists?(login_date: today)

    current_user.login_logs.create!(login_date: today)
  end
end
