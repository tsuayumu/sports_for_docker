class VirtualCurrencyTweet < ActiveRecord::Base
  belongs_to :virtual_currency_tweet_word
  belongs_to :twitter_user
end
