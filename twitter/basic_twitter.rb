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


binding.pry

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
puts "[Read] Twitter Feed, [User] Details, [Status], [Friends] List, [Mentions], [Fav]orited Tweets, Read About [Other] Users, [Quit]"
answer = gets.chomp
answer.downcase!

	case answer
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


# client.update('Tweeting from Ruby #LearnedAtGA')
# 