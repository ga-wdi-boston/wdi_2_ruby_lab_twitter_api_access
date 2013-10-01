require 'pry'
require 'twitter'
require 'dotenv'
require 'class'

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end

binding.pry
puts "What would you like to view? Enter a number:"
puts "1 - Recent Tweets"
puts "2 - Friends"
puts "3 - User Details"
puts "4 - # of Lists Subscribed To"
puts "5 - # of Favorited Tweets"
puts "6 - Number of Friends"
puts "7 - Mentions"
input = gets.chomp

case input
when "1"
	recent_tweets

when "2"
	list_friends

when "3"
	user_description

when "4"
	client_lists

when "5"
	favorite_tweets

when '6'
	client.friendship(username, otheruser)

# when "7"
# 	mentions = []
# 	client.mentions(username) do |mention|
#  		mentions << mention.text
#  	x = mentions
# 	puts x
# 	end

else
	puts "Try again."

end

