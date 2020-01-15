require_relative 'slot.rb'
require_relative 'talk.rb'

class ConferenceManager

  def initialize(slot_options:, qualified_talks:)
    self.qualified_talks = Talk.build_all(qualified_talks)
    build_slots(slot_options)
  end

  def organize!
    allot_slots
  end

  def selected_talks
    slots.flat_map(&:alloted_talks)
  end

  def rejected_talks
    qualified_talks.reject(&:selected?)
  end

  private

  def allot_slots
    slots.each do |slot|
      slot.allot_talks(rejected_talks)
    end
  end

  def build_slots(slot_options)
    self.slots = []
    1.upto(slot_options[:number_of_tracks]) do |track_number|
      morning_slot = Slot.new(slot_options[:start_time], slot_options[:lunch_start_time], track_number)
      evening_slot = Slot.new(slot_options[:lunch_end_time], slot_options[:end_time], track_number)
      slots.push(morning_slot, evening_slot)
    end
  end

  attr_accessor :qualified_talks, :slots
end





