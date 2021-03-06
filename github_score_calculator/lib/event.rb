require_relative 'rest_client.rb'
require 'json'

class Event
  attr_accessor :score

  DEFAULT_SCORE = 1

  SCORES = {
    'IssuesEvent' => 7,
    'IssueCommentEvent' => 6,
    'PushEvent' => 5,
    'PullRequestReviewCommentEvent' => 4,
    'WatchEvent' => 3,
    'CreateEvent' => 2
  }

  SCORES.default = DEFAULT_SCORE

  def initialize(type)
    self.score = SCORES[type]
  end

  def self.fetch(profile_url)
    raw_events_data = RestClient.get(profile_url)
    parsed_events_data = JSON.parse(raw_events_data)
    all_events = []

    parsed_events_data.each do |data|
      event = self.new(data['type'])
      all_events.push(event)
    end

    all_events
  end
end
