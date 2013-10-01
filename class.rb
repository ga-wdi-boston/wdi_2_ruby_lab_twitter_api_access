class.rb

class Client
	attr_accessor :client

	def initialize(username)
		@client = username
		puts "What user to lookup?"
		username = gets.chomp
	end

	def recent_tweets
		recent_tweets = []
 		@client.user_timeline.each do |tweet|
		recent_tweets << tweet.text
			end
	end

	def list_friends
		friends_array = []
  		@client.friends(username).each do |friend|
  			friends_array << friend.name
  		end
  		friends_array.each do |friend| puts friend 
  		end
  	end

  	def client_lists
  		@client.lists(username) do |list|
		x = list.text
		puts x
		end
  	end

  	def user_description
  		@client.user(username).description
  	end

  	def friends_list
  		friends_list = []
		@client.friends(username) do |friends|
			friends_list << friends.text
		friends_list
		end
  	end


end