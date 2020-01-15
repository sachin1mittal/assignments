require 'csv'
require 'set'

class Filterer
  OUTPUT_FILE_PATH = "#{File.dirname(__FILE__)}/output.csv"

  def initialize(file_path, unwanted_sources, priority_sources)
    self.file_path = file_path
    self.unwanted_sources = unwanted_sources
    self.priority_sources = priority_sources
  end

  def generate_output
    generate_email_to_row_mapping

    CSV.open(OUTPUT_FILE_PATH, 'w') do |csv|
      mapped_data.values.each { |row| csv << row }
    end

    OUTPUT_FILE_PATH
  end

  private

  def generate_email_to_row_mapping
    self.mapped_data = {}
    emails_to_remove = Set.new

    CSV.foreach(file_path) do |row|
      email = row[1]
      source = row[2]

      if unwanted_sources.include?(source)
        emails_to_remove.add(email)
        next
      end

      if mapped_data[email].nil? || current_source_has_higher_priority?(email, source)
        mapped_data[email] = row
      end
    end

    emails_to_remove.each { |unwanted_email| mapped_data.delete(unwanted_email) }
  end

  def current_source_has_higher_priority?(email, source)
    existing_source_in_mapping = mapped_data[email][2]
    existing_source_index = priority_sources.index(existing_source_in_mapping) || priority_sources.size
    source_index = priority_sources.index(source) || priority_sources.size
    existing_source_index > source_index
  end

  attr_accessor :file_path, :unwanted_sources, :priority_sources, :mapped_data
end
