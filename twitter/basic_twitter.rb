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

def return_friends(client)
	friends = []
	client.friends.attrs[:users].each do |user|
		friends << user[:name]
	end
	return friends
end

def tweet_list(list, client)
	list = []
	client.list.each do |tweet|
		list << "#{tweet.attrs[:user][:screen_name]}: #{tweet.attrs[:text]}"
	end
	return list
end

puts "Welcome to @abbygezunt's Twitter page.  What would you like to see?"
puts "[Read] Twitter Feed, [User] Details, [Recent] Tweets, [Friends] List, [Lists], [Mentions], [Fav]orited Tweets"
answer = gets.chomp
answer.downcase!

case answer
when 'read'
	puts "Your friends' most recent tweets:"
	puts tweet_list(home_timeline, client)
when 'user'
when 'recent'
when 'friends'
	puts "Abby's friends list:"
	puts return_friends(client)
when 'lists'
when 'mentions'
	puts "Tweets about Abby:"
	puts tweet_list(mentions, client)
when 'fav'
	puts "Abby's favorites:"
	puts tweet_list(favourites, client)
else
	puts "Input not recognized"
end


# Recent Tweets, Friend List, User Details, Lists, Favorited Tweets

# puts "Would you like to know about anyone else?  Type their username."
# answer = gets.chomp
# username = client.user(answer)

# puts "#{username.attrs[:name]} has #{username.attrs[:friends_count]} friends.  Their most recent status was: \n\"#{username.attrs[:status][:text]}\"."


# client.lists
# client.favorites(user)
# client.user.

# client.sample do |tweet|
#   puts tweet.text
# end







# client.user(username) do |tweet|
#   puts tweet.text
# end

# client.friends.all

# Twitter::User

# friend list:
# def friends_list(username)
# 	friends = []
# 	client.friends[:users].each do |friend|
# 		friends << friend[:name]
# 	end
# 	return friends
# end

# puts friends_list(answer)



# recent tweets: 
# puts client.user_timeline(answer)


# What would you like to see? 
# Recent Tweets, Friend List, User Details, Lists, Favorited Tweets

# client.update('Tweeting from Ruby #LearnedAtGA')
# 