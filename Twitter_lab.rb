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



puts "Hello, welcome to my twitter filter! Please start with which profile you would like to browse?"
username  = gets.chomp.to_s

puts "Here are your commands and please type them exactly: recent_tweets , 
	friends_list , user_followers , user_details, and lists"

request = gets.chomp.to_s

# lists_arrary = []


case request

	when "recent_tweets"
	 	request = client.user_timeline(username).each do |tweet|
    puts tweet[:text] 

binding.pry

 	when "friends_list"
 	puts client.friends.all(username)

  when "user_followers"
 	puts client.followers(username)
 
 
  when "user_details"
  puts client.user(username) 

 	#when "lists" 

 	else 
	puts "Sorry, that is not one of the avaliable parameters. Please try again!" 
end








