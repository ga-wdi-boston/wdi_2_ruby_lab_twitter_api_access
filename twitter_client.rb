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
client = client.user(username)

puts "What would you like to view? Enter a number:"
puts "1 - Most Recent Tweet"
puts "2 - Friend Count"
puts "3 - User Details"
puts "4 - # of Lists Subscribed To"
puts "5 - # of Favorited Tweets"
input = gets.chomp

case input
when "1"
	x = client.user_timeline

when "2"
	x = client.friends.take(20)

when "3"
	x = client.description

when "4"
	x = client.listed_count

when "5"
	x = client.favorites_count
else
	puts "Try again."

end

puts "Your answer is #{x}."

binding.pry