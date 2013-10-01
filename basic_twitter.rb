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

# 1. Build a Twitter client
# 2. Split into multiple files as appropriate
# 3. Write classes or methods as appropriate
# 4. Read chaper 4 Blocks & Iterators

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
  attr_accessor :client, :username
  
  def initialize(client, username)
    @client   = client
    @username = username
  end

  def get_recent_tweets
    recent_tweets = []
    @client.user_timeline(@@twitter_handle).each do |tweet|
      recent_tweets << tweet[:text]
    end
    recent_tweets
  end

  def get_friends
  end

  def get_followers
    followers = {}
    @client.followers(@@twitter_handle).each do |follower|
      followers[follower[:screen_name]] = follower[:name]
    end
    followers
  end

  def get_user_details

  end

  def get_retweets
    retweets = {}
  end

  def get_favorites
    favorites = {}
    @client.favorites(@@twitter_handle).each do |favorite|
      favorites[favorite[:user][:screen_name]] = favorite[:text]
    end
    favorites
  end
end
twitsy = TwitterClient.new(client)
twitsy.interface
binding.pry
