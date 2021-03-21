class TwitterUser < ActiveRecord::Base
  has_many :virtual_currency_tweets
end
