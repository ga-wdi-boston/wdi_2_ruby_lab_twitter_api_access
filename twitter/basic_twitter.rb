require 'twitter'
require 'pry'
require 'dotenv'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end


# binding.pry

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
	end
	return arr
end

answer = ""

while answer

puts
puts "Welcome to @abbygezunt's Twitter page.  What would you like to see?"
puts "[Read] Twitter Feed, [User] Details, [Recent] Tweets, [Friends] List, [Lists], [Mentions], [Fav]orited Tweets, Read About [Other] Users, [Quit]"
answer = gets.chomp
answer.downcase!

	case answer
	when 'read'
		puts "Your friends' most recent tweets:"
		puts read_feed(client)
	when 'user'
	when 'recent'
	when 'friends'
		puts "Abby's friends list:"
		puts return_friends(client)
	when 'lists'
	when 'mentions'
		puts "Tweets about Abby:"
		puts mentions(client)
	when 'fav'
		puts "Abby's favorites:"
		puts favorites(client)
	when 'other'
		puts "Which Twitter user would you like to read about?"
		answer = gets.chomp
		puts other_user_info(answer)
	when 'quit'
		Process.exit
	else
		Process.exit
	end


end


# client.update('Tweeting from Ruby #LearnedAtGA')
# 