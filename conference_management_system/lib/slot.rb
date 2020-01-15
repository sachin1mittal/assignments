require 'date'
require_relative 'talk.rb'

class Slot
  attr_accessor :remaining_duration, :track_number, :start_time, :end_time,
                :alloted_talks, :rejected_talks

  MINUTES_PER_DAY = 24 * 60

  def initialize(start_time, end_time, track_number)
    self.start_time = parse_time(start_time)
    self.end_time = parse_time(end_time)
    self.track_number = track_number
    self.remaining_duration = total_duration # in minutes
    self.alloted_talks = []
  end

  def allot_talks(rejected_talks)
    self.rejected_talks = rejected_talks
    allot_direct_in_increasing_order
    replace_small_duration_talks
    restore_lightning_talks
    set_alloted_talks_timings
  end

  private

  def total_duration
    @total_duration ||= ((end_time - start_time) * MINUTES_PER_DAY).to_i
  end

  def parse_time(time)
    begin
      DateTime.strptime(time, '%I:%M %p')
    rescue ArgumentError
      raise InvalidInput.new("Invalid Time Input: #{time}")
    end
  end

  def set_alloted_talks_timings
    alloted_minutes = 0
    alloted_talks.each do |talk|
      talk.slot = self
      talk.start_time = start_time + (alloted_minutes / MINUTES_PER_DAY.to_f)
      alloted_minutes += talk.duration
    end
  end

  def restore_lightning_talks
    lightning_replacement_talk_index = alloted_talks.index do |talk|
      talk.lightning_replacement?
    end

    if lightning_replacement_talk_index
      alloted_talks[lightning_replacement_talk_index].slot = self
      alloted_talks[lightning_replacement_talk_index, 1] = Talk.lightning_talks
    end
  end

  def allot_direct_in_increasing_order
    rejected_talks.each do |talk|
      break if remaining_duration < talk.duration
      alloted_talks.push(talk)
      self.remaining_duration -= talk.duration
    end

    self.rejected_talks -= alloted_talks
  end

  def replace_small_duration_talks
    rejected_talks.each do |talk|
      break if self.remaining_duration.zero?

      replaceable_talk = alloted_talks.find do |r_talk|
        talk.duration > r_talk.duration &&
          (talk.duration - r_talk.duration) <= self.remaining_duration
      end
      break if !replaceable_talk

      alloted_talks.delete(replaceable_talk)
      alloted_talks.push(talk)
      self.remaining_duration -= (talk.duration - replaceable_talk.duration)
    end
  end
end
