require 'twitter'
require 'pry'
require 'dotenv'
Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

#binding.pry

# Prompt for twitter handle.
# What would you like: recent tweets, friend list, user details, lists (1 - 4).

# Define methods to interact with the twitter API and get info. 
def recent_tweets(handle, client)
	tweets =  client.user_timeline(handle)
	tweets.each do |tweet|
		puts tweet.attrs[:text]
	end	
end

def following_list(handle, client)
	users = client.following(handle).attrs[:users]
	users.each do |user|
		puts user[:name]
	end	
end

def user_details(handle, client)
	hash = client.user(handle)
	puts hash[:description]
end

def lists(handle, client)
	lists = client.lists(handle)
	lists.each do |list|
		puts list.attrs[:name]
	end
end

# Get user input for twitter handle and desired info. 
puts "Twitter handle?"
handle = gets.chomp

puts "Do you want Recent Tweets, Following List, User Details or Lists?"
response = gets.chomp

# Response logic. Includes error handling for invalid user for User Details.
if response == "Recent Tweets"
	recent_tweets(handle, client)
elsif response == "Following List"
	following_list(handle, client)
elsif response == "User Details"
	begin
		user_details(handle, client)
	rescue Twitter::Error::NotFound => err
		puts "#{err} because the user doesn't exist or hasn't yet added details."
	end
elsif response == "Lists"
	lists(handle, client)
else
	puts "Sorry, I don't recognize that command."	
end


