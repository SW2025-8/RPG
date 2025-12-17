class TimeTestJob < ApplicationJob
  def perform
    LineBot.broadcast
  end
end

