require 'twitter'
require 'pry'
require 'dotenv'
Dotenv.load
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE



binding.pry


# streamig_@client.user do |tweet|
#   puts tweet.text
# end