require 'twitter'
require 'dotenv'
require 'pry'
Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["CONSUMER_KEY"]
  config.consumer_secret     = ENV["CONSUMER_SECRET"]
  config.access_token        = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# binding.pry
# puts "What is your Twitter handle?"
# twitter_handle = gets.chomp
# puts "What information would you like about #{twitter_handle}?"
# puts "1. Recent Tweets"
# puts "2. Friend List"
# puts "3. Followers"
# puts "4. User Details"
# puts "5. Lists"
# puts "6. Favorites"

class TwitterClient
  # attr_reader :recent_tweets, :friends, :followers,
  #             :user_details, :lists, :favorites
  # def initializer

  # end
  def interface
    puts "What is your Twitter handle?"
    twitter_handle = gets.chomp
    puts "What information would you like about #{twitter_handle}?"
    puts "1. Recent Tweets"
    puts "2. Friend List"
    puts "3. Followers"
    puts "4. User Details"
    puts "5. Lists"
    puts "6. Favorites"
    choice = gets.chomp.to_i
  
    case choice
      when 1 then get_recent_tweets
      when 2 then get_friend_list
      when 3 then get_followers
      when 4 then get_user_details
      when 5 then get_lists
      when 6 then get_favorites
    end
    choice
  end

  def get_recent_tweets
  end

  def get_friend_list
  end

  def get_followers
  end

  def get_user_details
  end

  def get_lists
  end

  def get_favorites
  end
end
twitsy = TwitterClient.new
binding.pry
