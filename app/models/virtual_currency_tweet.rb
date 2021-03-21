class VirtualCurrencyTweet < ActiveRecord::Base
  belongs_to :virtual_currency_tweet_word

  scope :one_day, -> (date){
    where(created_at: (1.days.ago)..(date))
  }
end
