class VirtualCurrencyTweetWord < ActiveRecord::Base
  belongs_to :virtual_currency
  has_many :virtual_currency_tweets
end
