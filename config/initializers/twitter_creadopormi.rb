require 'twitter'

T = Twitter::REST::Client.new do |config|
  config.consumer_key        = "abc"
  config.consumer_secret     = "abc"
  config.access_token        = "abc"
  config.access_token_secret = "abc"
end