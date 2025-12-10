class LineTestController < ApplicationController
  def broadcast
    response = LineBot.broadcast_message

    render plain: "LINE response: #{response.code}"
  end
end

