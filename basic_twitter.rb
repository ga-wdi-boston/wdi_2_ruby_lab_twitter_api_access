require 'twitter'
require 'pry'
require 'dotenv'
require_relative 'twitter_config'

puts "What username would you like to find information on?"

username = gets.chomp.to_s

puts "What would you like to see? (Options are recent_tweets, friends_list, user_details, lists, fav_tweets, stream)"

input = gets.chomp.to_s

if input == "recent_tweets"
   @client.user_timeline(username).each do |tweet|
    puts tweet[:text]
  end
elsif input == "friends_list"
  @client.friends(username).each do |friend|
    puts friend[:name]
  end
elsif input == "user_details"
  puts "Name: #{@client.user(username.to_s).name}"
  puts "Description: #{@client.user(username.to_s).description}"
  puts "Location: #{@client.user(username.to_s).location}"
  puts "Friends Count: #{@client.user(username.to_s).friends_count}"
  puts "Follower Count: #{@client.user(username.to_s).followers_count}"
  puts "Tweets Count: #{@client.user(username.to_s).tweets_count}"
elsif input == "lists"
   @client.lists(username).each do |list|
    puts list[:name]
  end
elsif input == "fav_tweets"
  @client.favourites(username).each do |favourite|
    puts favourite[:text]
  end
elsif input == "stream"
  topics = "#{username}"
  @streaming_client.filter(:track => topics) do |tweet|
  puts tweet.text 
  end
else
  puts "incorrect input please try again"
end
