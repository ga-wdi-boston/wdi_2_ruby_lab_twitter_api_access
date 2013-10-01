def print_friends(my_user)
	puts "Friends:"
	friends_array = []
	$client.friends(my_user.to_s).each {|friend| friends_array << friend.name}	
	friends_array.each {|friend| puts friend}
end


def print_user_details(my_user)
	puts "Name: #{$client.user(my_user.to_s).name}"
	puts "Description: #{$client.user(my_user.to_s).description}"
	puts "Location: #{$client.user(my_user.to_s).location}"
	puts "Friends Count: #{$client.user(my_user.to_s).friends_count}"
	puts "Follower Count: #{$client.user(my_user.to_s).followers_count}"
	puts "Tweets Count: #{$client.user(my_user.to_s).tweets_count}"
end

def user_summary(user)
	print_user_details(user)
	print_friends(user)
end

def follow(user)
	$client.follow(user.to_s)
end

def tweet(text)
	$client.update(text.to_s)
end

def view_tweets(my_user)
	tweets_array = []
	$client.user_timeline(my_user.to_s).each {|tweet| tweets_array << tweet.text}	
	tweets_array.each {|tweet| puts tweet}
	puts " "
end
