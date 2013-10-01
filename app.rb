require 'twitter'
require 'dotenv'
require 'pry'
Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV["CONSUMER_KEY"]
  config.consumer_secret = ENV["CONSUMER_SECRET"]
  config.access_token = ENV["ACCESS_TOKEN"]
  config.access_token_secret = ENV["ACCESS_SECRET"]
end

def live_stream(client)
  client = Twitter::Streaming::Client.new do |config|
    config.consumer_key = ENV["CONSUMER_KEY"]
    config.consumer_secret = ENV["CONSUMER_SECRET"]
    config.access_token = ENV["ACCESS_TOKEN"]
    config.access_token_secret = ENV["ACCESS_SECRET"]
  end
  topics = ["bieber"]
  client.filter(:track => topics.join(",")) { |tweet| puts tweet.text }
end

def recent_tweets(handle, client)
  return client.user_timeline(handle).collect { |tweet| tweet.text }
end

def list_followers(handle, client)
  return client.followers(handle).take(25).collect { |follower| follower.screen_name }
end

def list_mentions(handle, client)
  return client.mentions(handle).collect { |mentions| mentions.text }
end

def list_retweets(handle, client)
  return client.retweeted_by_user(handle).take(25).collect { |tweets| tweets.screen_name }
end

def following_count(handle, client)
  count = 0
  client.following(handle).each { |following| count += 1 }
  return count
end

def retweet_count(handle, client)
  count = 0
  client.retweeted_by_user(handle).each { |retweets| count += 1 }
  return count
end

def tagged_ga(client)
 return client.search('#LearnedAtGA').collect { |tweet|
  "#{tweet.user.screen_name}: #{tweet.text}" }
end

def twitter_stats(handle, client)
  follower_count = following_count(handle, client).to_f
  follows_count = following_count(handle, client).to_f
  
  puts "Friend Count: #{client.user(handle).friends_count}
  Follows Count: #{follows_count}
  Follower Count: #{follower_count}
  Tweet Count: #{client.user(handle).tweets_count}
  Retweets: #{retweet_count(handle, client)}
  Follows/Followers Ratio: #{follower_count / follows_count} "
end

handle = "bostonlowbrow"

puts <<PARAGRAPH
You can:
1. list recent tweets
2. list recent followers
3. lsit mentions
4. list retweets
5. list basic stats
6. list tweets tagged #LearnedAtGA
7. list justin bieber mentions
PARAGRAPH

select = gets.chomp.to_i

case select
  when 1
    puts recent_tweets(handle, client)
  when 2
    puts list_followers(handle, client)
  when 3
    puts list_mentions(handle, client)
  when 4
    puts list_retweets(handle, client)
  when 5
    puts twitter_stats(handle, client)
  when 6
    puts tagged_ga(client)
  when 7
    puts live_stream(client)
  end


#FIX COUNTS IN 5
#FIX mentions, retweets?
#export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt