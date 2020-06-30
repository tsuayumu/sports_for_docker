require 'twitter_client'

class DailyLineupManageController < ApplicationController
  def create
    date = Date.parse(params[:date])
    team = Team.find(params[:team_id])

    daily_lineup_manage = DailyLineupManage.create_by!(
      team_id: params[:team_id],
      date: date,
      lineup: params[:lineup]
    )

    tweet_text = ''
    tweet_text << "#{team.name} #{date.strftime("%-m月%-d日")}のスタメン\r\r"
    daily_lineup_manage.daily_lineups.each.with_index(1) do |l, i|  
      tweet_text << "#{i}番　#{l.name}\r"
    end
    request_url = "http://sports-memory.com/game_highlight/#{team.name_en}/#{date.strftime('%Y%m%d')}"
    tweet_text << "\r詳しくはこちら\r#{request_url} \r\r"
    tweet_text << "##{team.name} ##{date.strftime("%-m月%-d日")}のスタメン"

    twitter_client.update(tweet_text)
  end

  private

  def twitter_client
    TwitterClient.new
  end
end
