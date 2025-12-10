class LineTestController < ApplicationController
  def broadcast
    response = LineBot.broadcast

    render plain: "LINE response: #{response.code}"
  end
end

