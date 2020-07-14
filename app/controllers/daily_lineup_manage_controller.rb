require 'twitter_client'

class DailyLineupManageController < ApplicationController
  def index
    @date = Date.parse(params[:date])
    @team = Team.team(params[:team])
    @daily_lineup_manage = DailyLineupManage.find_by(
      team: @team,
      date: @date
    )

    render json: {
      date: @date.strftime("%Y/%m/%d"),
      team: {
        id: @team.id,
        name: @team.name,
        name_en: @team.name_en
      },
      select_players: res_select_players,
      selected_players: default_lineup_player_ids
    }
  end

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
    request_url = "http://sports-memory.com/game/#{team.name_en}/#{date.strftime('%Y%m%d')}"
    tweet_text << "\r詳しくはこちら\r#{request_url} \r\r"
    tweet_text << "##{team.name} ##{date.strftime("%-m月%-d日")}のスタメン"

    twitter_client.update(tweet_text)
  end

  private

  def twitter_client
    TwitterClient.new
  end

  def default_lineup_player_ids
    if @daily_lineup_manage
      @daily_lineup_manage.daily_lineups.map{|lineup| lineup.batter_id}
    else
      OpeningStartingLineup::DefaultLineups.new(params[:team], @date.year + 1).lineup_player_ids
    end
  end

  def res_select_players
    select_batters.map do |b|
      res_batter(b)
    end
  end

  def res_batter(batter)
    if batter.batter_record
      {
        batter_id: batter.id,
        name: batter.name.gsub(/\p{blank}/," "),
        average: (batter.batter_record.average*1000).floor,
        homerun: batter.batter_record.homerun,
        rbi: batter.batter_record.rbi
      }
    else
      {
        batter_id: batter.id,
        name: batter.name.gsub(/\p{blank}/," ")
      }
    end
  end

  def select_batters
    Batter.where(team_id: @team.id, year: @date.year.to_i + 1)
  end
end
