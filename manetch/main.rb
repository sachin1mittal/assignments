require_relative 'filterer'

input_file = 'Enter Input File'
unwanted_sources = 'Enter sources to remove'
priority_sources = 'Enter priority list of sources'

output_file = Filterer.new(input_file, unwanted_sources, priority_sources).generate_output
puts "Your Output is stored in #{output_file}"
