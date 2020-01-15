require_relative 'event.rb'

class User
  def initialize(username:)
    self.username = username
  end

  def github_score
    events = Event.fetch(github_events_url)
    events.inject(0) { |res, event| res += event.score }
  end

  private

  def github_events_url
    "https://api.github.com/users/#{username}/events/public"
  end

  attr_accessor :username
end
