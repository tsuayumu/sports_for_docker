class VirtualCurrencyTweetWordController < ApplicationController
  def show
    tweet_word = VirtualCurrencyTweetWord.find(params[:id])
    render json: {
      title: "#{tweet_word.virtual_currency.name} #{tweet_word.word}",
      tweet_word: res_per_day(tweet_word)
    }
  end

  private

  def res_per_day(tweet_word)
    tweet_word.virtual_currency_tweets.map do |tweet|
      {
        text: tweet.text,
        tweeted_at: tweet.tweeted_at.strftime("%Y-%m-%-d %H:%M"),
        favorite_count: tweet.favorite_count,
        retweet_count: tweet.retweet_count,
        name: tweet.name,
        followers_count: tweet.followers_count
      }
    end
  end
end
