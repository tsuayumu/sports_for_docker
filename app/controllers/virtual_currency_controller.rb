class VirtualCurrencyController < ApplicationController
  def index
    render json: res_json
  end

  private

  def res_json
    { virtual_currencys: res_virtual_currencys }
  end

  def res_virtual_currencys
    VirtualCurrency.all.map do |v|
      {
        id: v.id,
        name: v.name,
        tweet_infos: res_tweet_infos(v)
      }
    end
  end

  def res_tweet_infos(virtual_currency)
    virtual_currency.virtual_currency_tweet_words.map do |tw|
      {
        id: tw.id,
        word: tw.word,
        per_day: res_per_day(tw),
        count: tw.virtual_currency_tweets.one_day(Time.now).size,
        rate: res_tweet_info_rate(tw)
      }
    end
  end

  def res_per_day(tweet_word)
    tweet_word.virtual_currency_tweets.map do |tweet|
      {
        text: tweet.text,
        user_id: tweet.twitter_user_id
      }
    end
  end

  def res_tweet_info_rate(tw)
    ( tw.virtual_currency_tweets.one_day(Time.now).size.to_f / tw.virtual_currency_tweets.one_day(1.days.ago).size.to_f * 100 - 100 ).round(1)
  end
end
