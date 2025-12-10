require 'net/http'
require 'json'

class LineBot
  LINE_API = "https://api.line.me/v2/bot/message/broadcast"

  def self.broadcast
    uri = URI.parse(LINE_API)

    header = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{ENV['LINE_CHANNEL_ACCESS_TOKEN']}"
    }

    body = {
      messages: [
        { type: "text", text: "おはよう! 調子はどう? クエストに挑戦しよう!" }
      ]
    }.to_json

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body

    response = https.request(request)
    Rails.logger.info "LINE API: #{response.code} - #{response.body}"
    response
  end
end

