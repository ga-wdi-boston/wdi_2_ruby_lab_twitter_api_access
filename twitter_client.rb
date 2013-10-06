require 'pry'
require 'twitter'
require 'dotenv'
require_relative 'class'

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end

# client = Twitter::Streaming::Client.new do |config|
# 	config.consumer_key        = ENV["CONSUMER_KEY"]
#   config.consumer_secret    = ENV["CONSUMER_SECRET"]
#   config.access_token        = ENV["ACCESS_TOKEN"]
#   config.access_token_secret = ENV["ACCESS_SECRET"]
# end

puts "What would you like to view? Enter a number:"
puts "1 - Recent Tweets"
puts "2 - Friends"
puts "3 - User Details"
puts "4 - # of Lists Subscribed To"
puts "5 - # of Favorited Tweets"
puts "6 - Number of Friends"
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
else
	puts "That's not a valid entry. Try again."

end

### fun with Twitter gem streaming


# topic = "obama"
# obama_tweets = []
# i = 0
# binding.pry
# client.filter(track: topic) do |tweet|
# 	if tweet.lang == 'en'
# 		i += 1
# obama_tweets << {username: tweet.attrs[:user][:screen_name],
# 				tweet: tweet.text}
# 		puts "#{i} tweets gathered"
# 	end
# 	break if i > 100
# end

# words = []
# words = obama_tweets.map do |datum|
# 	datum[:tweet].split(" ")
# end

# words.flatten!

# finding frequency of each word and making into a hash
# with word as keys and frequency as values
# frequencies = {}

# words.each do |word|
# 	frequencies[word.to_sym] ||= 0
	# same as: frequencies[word.to_sym] => 0
	# if it exists, don't do anything, or move it to zero
	# if left side is nil, assign value on right
	# if it exists already in the new hash, don't add it
	# first time it finds each word, assign it zero. then increment it.
# 	frequencies[word.to_sym] +=1
# end


