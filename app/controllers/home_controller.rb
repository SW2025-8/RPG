class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    Rails.logger.info "### HOME#index called at #{Time.current}"
    Rails.logger.info "### hp=#{current_user.hp}, last=#{current_user.last_hp_ticked_at}"

    # ※ HP減少処理は ApplicationController 側で実行されるため、ここでは呼ばない

    @quests = current_user.quests.order(created_at: :asc)
  end
end
