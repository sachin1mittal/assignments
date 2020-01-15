class Screen

  def self.print_selected_talks(talks = [])
    return if talks.empty?
    puts '================= Selected Talks ================='
    print_talks(talks) do |talks, track_number|
      puts "\nTrack #{track_number}\n"
      talks.sort_by(&:start_time).each { |talk| puts talk.screen_printable_version }
    end
  end

  def self.print_rejected_talks(talks = [])
    return if talks.empty?
    puts "\n================= Rejected Talks =================\n"
    print_talks(talks) do |talks|
      talks.each { |talk| puts talk.screen_printable_version }
    end
  end

  def self.print_talks(talks)
    talks.group_by(&:track_number).each do |track_number, talks|
      yield(talks, track_number)
    end
  end

  private_class_method :print_talks
end

