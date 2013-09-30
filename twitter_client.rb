require 'pry'
require 'twitter'
require 'dotenv'

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end

puts "What user to lookup?"
username = gets.chomp
# client.user(username)
binding.pry
puts "What would you like to view? Enter a number:"
puts "1 - Most Recent Tweet"
puts "2 - Friend Count"
puts "3 - User Details"
puts "4 - # of Lists Subscribed To"
puts "5 - # of Favorited Tweets"
input = gets.chomp

case input
when "1"
	x = client.statuses.take(20)

when "2"
	friends = []
	client.friends(username).take(20).each do |friend|
		friends << friend.name
		x = friends
	end

when "3"
	x = client.description(username)
	#descriptoin method not working

when "4"
	x = client.lists(username)

when "5"
	x = client.favorites(username).to_s
else
	puts "Try again."

end

puts "Your answer is #{x}."

