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

class TwitterClient
  attr_accessor :client, :username
  
  def initialize(client, username)
    @client   = client
    @username = username
  end

  def get_name
    @client.user(@username).name
  end

  def get_recent_tweets
    recent_tweets = []
    @client.user_timeline(@username).each do |tweet|
      recent_tweets << tweet[:text]
    end
    recent_tweets
  end

  def get_following
    following = {}
    @client.following(@username).each do |followee|
      following[followee[:screen_name]] = followee[:name]
    end
    following
  end

  def get_followers
    followers = {}
    @client.followers(@username).each do |follower|
      followers[follower[:screen_name]] = follower[:name]
    end
    followers
  end

  def get_follower_count
    @client.user(@username).followers_count
  end

  def get_retweets
    retweets = {}
    @client.retweets(@username).each do |retweet|
      retweets[retweet[:user][:screen_name]] = retweet[:text]
    end
    retweets
  end

  def get_favorites
    favorites = {}
    @client.favorites(@username).each do |favorite|
      favorites[favorite[:user][:screen_name]] = favorite[:text]
    end
    favorites
  end
end
twitsy = TwitterClient.new(client, 'TheAllBox')
puts twitsy.get_name
puts twitsy.get_recent_tweets
puts twitsy.get_following
puts twitsy.get_followers
puts twitsy.get_follower_count
#puts twitsy.get_retweets
puts twitsy.get_favorites
binding.pry
