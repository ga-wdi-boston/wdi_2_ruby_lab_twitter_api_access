require 'twitter'
require 'pry'
require 'dotenv'
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

Dotenv.load

# client = Twitter::Streaming::Client.new do |config|
#   config.consumer_key        = ENV["CONSUMER_KEY"]
#   config.consumer_secret     = ENV["CONSUMER_SECRET"]
#   config.access_token        = ENV["ACCESS_TOKEN"]
#   config.access_token_secret = ENV["ACCESS_SECRET"]
# end

# topic = "obama"
# obama_tweets = []
# i = 0

# client.filter(track: topic) do |tweet|
# 	if tweet.lang == 'en'
# 		i += 1
# 		obama_tweets << {username: tweet.attrs[:user][:screen_name], tweet: tweet.text}
# 		puts "#{i} tweets gathered"
# 	end
# 	break if i >= 50
# end

# words = []
# obama_tweets.each do |item|
# 	words << item[:tweet].split(" ")
# end

# words.flatten!
# words.sort!
# new_words = words.map { |word| word.downcase }

# binding.pry

# histogram = Hash.new(0)
# new_words.each do |word|
# 	histogram[word.to_sym] += 1
# end

# histogram.sort_by |key, value|
# 	value
# end

# puts histogram


client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end

def stream(client, topic)
	  client = Twitter::Streaming::Client.new do |config|
	  config.consumer_key        = ENV["CONSUMER_KEY"]
	  config.consumer_secret     = ENV["CONSUMER_SECRET"]
	  config.access_token        = ENV["ACCESS_TOKEN"]
	  config.access_token_secret = ENV["ACCESS_SECRET"]
	end
	topics = [topic]
	client.filter(:track => topics.join(",")) do |tweet| 
		if tweet.lang == 'en'
			puts tweet.text
		end
	end
end

def recent_tweet(client)
	client.user.tweet.attrs[:text]
end

def tweet(client, text)
	client.update("#{text} \#SentFromTheTerminal")
end

def other_user_info(name)
	user = client.user(name)
	puts "#{user.attrs[:name]} has #{user.attrs[:friends_count]} friends.  Their most recent status was: \n\"#{user.attrs[:status][:text]}\"."
end

def return_friends(client)
	friends = []
	client.friends.attrs[:users].each do |user|
		friends << user[:name]
	end
	return friends
end

def favorites(client)
	arr = []
	client.favourites.each do |tweet|
		arr << "#{tweet.attrs[:user][:screen_name]}: #{tweet.attrs[:text]}"
	end
	return arr
end

def mentions(client)
	arr = []
	client.mentions.each do |tweet|
		arr << "#{tweet.attrs[:user][:screen_name]}: #{tweet.attrs[:text]}"
	end
	return arr
end

def read_feed(client)
	arr = []
	client.home_timeline.each do |tweet|
		arr << "#{tweet.attrs[:user][:screen_name]}: #{tweet.attrs[:text]}"
		arr << ""
	end
	return arr
end

def user_info(client)
	"#{client.user.attrs[:screen_name]}: #{client.user.attrs[:description]}"
end

answer = ""

while answer

puts
puts "Welcome to your Terminal Twitter page.  What would you like to see?"
puts "[Write] a New Tweet, Read Your Most [Recent] Tweet, [Stream] Tweets, [Read] Twitter Feed, [User] Details, [Status], [Friends] List, [Lists], [Mentions], [Fav]orited Tweets, Read About [Other] Users, [Quit]"
answer = gets.chomp
answer.downcase!

	case answer
	when 'write'
		puts "What do you want to tell the world?  I will automatically append \#SentFromTheTerminal."
		text = gets.chomp
		if text.length > 1
		  tweet(client, text)
		end
		puts "success!"
	when 'recent'
		puts recent_tweet(client)
	when 'stream'
		puts "What topics do you want to read about?"
		topic = gets.chomp
		puts stream(client, topic)
	when 'read'
		puts "Your friends' most recent tweets:"
		puts read_feed(client)
	when 'user'
		puts user_info(client)
	when 'status'
		puts client.user.attrs[:status][:text]
	when 'friends'
		puts "Your friends list:"
		puts return_friends(client)
	when 'mentions'
		puts "Tweets about you:"
		puts mentions(client)
	when 'fav'
		puts "Your favorites:"
		puts favorites(client)
	when 'lists'
		puts client.lists
	when 'other'
		puts "Which other Twitter user would you like to read about?"
		answer = gets.chomp
		puts other_user_info(answer)
	when 'quit'
		Process.exit
	else
		Process.exit
	end

end



