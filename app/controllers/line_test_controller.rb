class LineTestController < ApplicationController
  def broadcast
    response = LineBot.broadcast

    render plain: "LINE response: #{response.code}"
    render plain: "TOKEN=#{ENV['LINE_CHANNEL_ACCESS_TOKEN'].inspect}\nLINE=#{response.code}"
  end
end

