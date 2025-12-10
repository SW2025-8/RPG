class LineController < ApplicationController
  skip_before_action :verify_authenticity_token

  def webhook
    body = request.body.read
    puts body  # デバッグ用
    head :ok
  end
end

