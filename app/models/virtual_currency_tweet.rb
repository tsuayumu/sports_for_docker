class VirtualCurrencyTweet < ActiveRecord::Base
  belongs_to :virtual_currency_tweet_word
  belongs_to :twitter_user

  delegate :name, :followers_count, to: :twitter_user, allow_nil: true

  scope :one_day, -> (date){
    where(tweeted_at: (1.days.ago)..(date))
  }
end
