require_relative '../lib/user.rb'

username = 'dhh'
score = User.new(username: username).github_score
puts "#{username}'s github is #{score}"
