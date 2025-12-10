class LineController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, raise: false

  def webhook
    body = request.body.read
    render json: { status: "ok" }, status: 200
  end
end

