require 'twitter_client'

def twitter_client
  TwitterClient.new
end

add_search_words = ["", "仮想通貨", "買", "売"]

VirtualCurrency.find_each do |v|
  add_search_words.each do |add_search_word|
    search_word = "##{v.name} #{add_search_word}"
    search_result = twitter_client.search(search_word, count: 100)

    tweet_word = VirtualCurrencyTweetWord.find_or_create_by!(
      virtual_currency: v,
      word: add_search_word
    )

    search_result.attrs[:statuses].each do |tweet|
      next if tweet[:created_at].to_time > 24.hours.ago

      begin
        twitter_user = TwitterUser.find_or_create_by(
          origin_user_id: tweet[:user][:id],
          name: tweet[:user][:name],
          followers_count: tweet[:user][:followers_count]
        )
        VirtualCurrencyTweet.find_or_create_by!(
          virtual_currency_tweet_word: tweet_word,
          twitter_user_id: twitter_user,
          text: tweet[:text],
          tweeted_at: tweet[:created_at].to_time
        )
      rescue ActiveRecord::StatementInvalid
      end
    end
  end
end
