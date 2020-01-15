require_relative 'invalid_input.rb'

class Talk
  attr_accessor :duration, :title, :category, :start_time, :slot

  LIGHTNING_TALK_DURATION = 5
  LIGHTNING_TALKS = []

  def initialize(title, talk_duration)
    self.title = title
    calculate_duration(talk_duration)
  end

  def self.build_all(qualified_talks)
    talks = []

    qualified_talks.each do |talk|
      new_talk = self.new(talk.first, talk.last)
      if new_talk.normal?
        talks.push(new_talk)
      else
        lightning_talks.push(new_talk)
      end
    end

    lightning_talks_duration = lightning_talks.map(&:duration).sum
    lightning_replacement_talk = self.new(:lightning_replacement_talk, "#{lightning_talks_duration} minutes")
    talks.push(lightning_replacement_talk)

    talks.sort_by(&:duration)
  end

  def self.lightning_talks
    LIGHTNING_TALKS
  end

  def lightning_replacement?
    self.title == :lightning_replacement_talk
  end

  def normal?
    self.category == :normal
  end

  def lightning?
    self.category == :lightning
  end

  def selected?
    !self.slot.nil?
  end

  def screen_printable_version
    printable_duration = lightning? ? 'lightning talk' : "#{duration} minutes"
    "#{start_time&.strftime('%I:%M %p')} #{title} #{printable_duration}".strip
  end

  def track_number
    self.slot&.track_number
  end

  private

  def calculate_duration(talk_duration)
    raise InvalidInput.new('Talk duration is Invalid') if !(talk_duration =~ duration_regex)
    if talk_duration.to_i.zero?
      self.category = :lightning
      self.duration = LIGHTNING_TALK_DURATION
    else
      self.category = :normal
      self.duration = talk_duration.to_i
    end
  end

  def duration_regex
    /^(\d+\sminutes|lightning talk)$/
  end
end
