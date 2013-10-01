require 'twitter'
require 'pry'
require 'dotenv'
Dotenv.load

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret    = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end

def print_friends(my_user)
	friends_array = []
	$client.friends(my_user.to_s).each {|friend| friends_array << friend.name}	
	friends_array.each {|friend| puts friend}
end


def print_user_details(my_user)
	puts "Name: #{$client.user(my_user.to_s).name}"
	puts "Description: #{$client.user(my_user.to_s).description}"
	puts "Location: #{$client.user(my_user.to_s).location}"
	puts "Friends Count: #{$client.user(my_user.to_s).friends_count}"
	puts "Follower Count: #{$client.user(my_user.to_s).followers_count}"
	puts "Tweets Count: #{$client.user(my_user.to_s).tweets_count}"
end

def user_summary(user)
	print_user_details(user)
	print_friends(user)
end

def follow(user)
	$client.follow(user.to_s)
end

def tweet(text)
	$client.update(text.to_s)
end

def view_tweets(user)
	$client.user_timeline(user.to_s)
end




binding.pry



