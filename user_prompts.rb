require_relative 'methods'

def prompt_user

	puts "What would you like to do?"
	puts "You can write a tweet (1), follow someone (2), view a user summary (3), or view a user's tweets! (4)"
	user_input = gets.chomp

	if user_input == "1"
		puts "Great! What would you like to say?"
		tweet_message = gets.chomp.to_s
		tweet(tweet_message)

	elsif user_input == "2"
		puts "OK! Who do you want to follow?"
		user_to_follow = gets.chomp.to_s
		follow(user_to_follow)

	elsif user_input == "3"
		puts "Who would you like to view a summary of?"
		user_to_summarize = gets.chomp.to_s
		user_summary(user_to_summarize)

	else
		puts "Whose tweets do you want to see?"
		user_to_view_tweets = gets.chomp.to_s
		view_tweets(user_to_view_tweets)
	end

end