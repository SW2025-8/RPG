class LoginCalendarsController < ApplicationController
  def show
    @month = params[:month] ? Date.parse(params[:month]) : Date.current
    @start_date = @month.beginning_of_month
    @end_date   = @month.end_of_month

    @login_dates = current_user.login_logs
                               .where(login_date: @start_date..@end_date)
                               .pluck(:login_date)
  end
end
