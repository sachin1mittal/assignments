require_relative '../lib/conference_manager.rb'
require_relative '../lib/screen.rb'

############################ INPUTS ###################################

slot_options = {
  number_of_tracks: 2,
  start_time: '09:00 AM',
  end_time: '05:00 PM',
  lunch_start_time: '12:00 PM',
  lunch_end_time: '01:00 PM'
}

qualified_talks = [
  ['Pryin open the black box', '60 minutes'],
  ['Migrating a huge production codebase from sinatra to Rails', '45 minutes'],
  ['How does bundler work', '30 minutes'],
  ['Sustainable Open Source', '45 minutes'],
  ['How to program with Accessiblity in Mind', '45 minutes'],
  ['Riding Rails for 10 years', 'lightning talk'],
  ['Implementing a strong code review culture', '60 minutes'],
  ['Scaling Rails for Black Friday', '45 minutes'],
  ['Docker isnt just for deployment', '30 minutes'],
  ['Callbacks in Rails', '30 minutes'],
  ['Microservices, a bittersweet symphony', '45 minutes'],
  ['Teaching github for poets', '60 minutes'],
  ['Test Driving your Rails Infrastucture with Chef', '60 minutes'],
  ['SVG charts and graphics with Ruby', '45 minutes'],
  ['Interviewing like a unicorn: How Great Teams Hire', '30 minutes'],
  ['How to talk to humans: a different approach to soft skills', '30 minutes'],
  ['Getting a handle on Legacy Code', '60 minutes'],
  ['Heroku: A year in review', '30 minutes'],
  ['Ansible : An alternative to chef', 'lightning talk'],
  ['Ruby on Rails on Minitest', '30 minutes'],
  ['Ruby on Rails on Minitest2', '60 minutes']
]

############################ INPUTS ENDS ###################################

begin
  conf_manager = ConferenceManager.new(
    slot_options: slot_options,
    qualified_talks: qualified_talks
  )

  conf_manager.organize!
  Screen.print_selected_talks(conf_manager.selected_talks)
  Screen.print_rejected_talks(conf_manager.rejected_talks)
rescue InvalidInput => error
  puts error.message
end

