class TwitterClient
  CONSUMER_KEY = "QrC8PkDJAgKn0nI5hXlibfE2o"
  ACCESS_TOKEN = "1223483503901175810-YeSlvMxUrSa0haH2yScGjcGpmQIEwR"

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = CONSUMER_KEY
      config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token = ACCESS_TOKEN
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  def update(text)
    @client.update(text) unless ENV["DOCKER_ENV"]
  end

  def search(text)
    @client.search(text, count: 5, result_type: "recent",  exclude: "retweets")
  end
end
