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
# Prompt for username
# gets.chomp 'rmazzotti'
## recent tweets
## friends list
## user details
## List

class TwitterApp
	attr_accessor :client

	def initialize(client)
	binding.pry
		puts "What's your username?"
		@username = gets.chomp
		@client = client
	end

	def recent_tweets(r_tweets)
		@client.user_timeline.each do |tweet|
			puts tweet.text
		end	
	end	

	def friends_list(f_list)
		@client.friends do |friends|
			puts friends.text
		end
	end

	def user_details(u_details)
		@client.user do |user|
			puts user.text
		end
	end

	def lists(l_lists)
		@client.list do |list|
			list.text
		end
	end

end

app = TwitterApp.new(client)