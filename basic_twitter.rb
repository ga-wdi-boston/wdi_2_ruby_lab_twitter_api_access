require 'twitter'
require 'pry'
require 'dotenv'
Dotenv.load
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end

puts "What username would you like to find information on?"

# binding.pry
username = gets.chomp.to_s

puts "What would you like to see? (Options are recent_tweets, friends_list, user_details, lists, fav_tweets)"

input = gets.chomp.to_s
tweet_list = []
lists_list = []
if input == "recent_tweets"
   client.user_timeline(username).each do |tweet|
    puts tweet[:text]
  end
elsif input == "friends_list"
  client.friends(username).each do |friend|
    puts friend[:name]
  end
elsif input == "user_details"
  puts "Name: #{client.user(username.to_s).name}"
  puts "Description: #{client.user(username.to_s).description}"
  puts "Location: #{client.user(username.to_s).location}"
  puts "Friends Count: #{client.user(username.to_s).friends_count}"
  puts "Follower Count: #{client.user(username.to_s).followers_count}"
  puts "Tweets Count: #{client.user(username.to_s).tweets_count}"
elsif input == "lists"
   client.lists(username).each do |list|
    puts list[:name]
  end
elsif input == "fav_tweets"
  client.favourites(username).each do |favourite|
    puts favourite[:text]
  end
else 
  puts "incorrect input please try again"
end
