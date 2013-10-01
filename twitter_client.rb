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
puts "6 - Number of Friends"
puts "7 - Mentions"
input = gets.chomp

case input
when "1"
	x = client.user(username).statuses.take(20)
	#statuses doesn't work

when "2"
	# friends = []

	friends_array = []
  	client.friends(username.to_s).take(5).each do |friend|
  		friends_array << friend.name
  		end
  	friends_array.each do |friend| puts friend 
  		end
	# client.friends(username).take(20).each do |friend|
	# 	friends << friend[:name]
	# 	x = friends

when "3"
	x = client.user(username).description
	#this works

when "4"
	x = client.lists(username)
	#this works

when "5"
	# x = client.favorites(username).take(5)
	favorites = []
	client.favorites(username).take(5).each do |x|
		favorites << x[:name] 
		favorites
		end

	# favorites.each do |x| x
when '6'
	x = client.user(username).friends_count

when "7"
	x = client.mentions

else
	puts "Try again."

end

puts "Your answer is #{x}."

