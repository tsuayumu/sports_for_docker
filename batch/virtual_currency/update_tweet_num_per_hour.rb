require 'twitter_client'

def twitter_client
  TwitterClient.new
end

VirtualCurrency.find_each do |v|
  search_name = "##{v.name}"
  search_result = twitter_client.search(search_name, count: 100)
  tweet_num_per_hour = search_result.attrs[:statuses].select{|sr| sr[:created_at].to_time > 1.hours.ago }.count

  v.update!(tweet_num_per_hour: tweet_num_per_hour)
end
