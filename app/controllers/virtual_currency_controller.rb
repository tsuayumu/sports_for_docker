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
        name: v.name,
        tweet_num_per_hour: v.tweet_num_per_hour
      }
    end
  end
end
