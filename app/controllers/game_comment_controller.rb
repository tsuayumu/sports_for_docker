class GameCommentController < ApplicationController
  def index
    @date = Date.parse(params[:date])
    @team = Team.team(params[:team])
    @game_comments = @team.game_comments.where(date: @date)
    @daily_lineup_manage = DailyLineupManage.find_by(
      team: @team,
      date: @date
    )

    render json: {
      date: @date.strftime("%Y/%m/%d"),
      game_comment_texts: res_game_comment_texts,
      team: {
        id: @team.id,
        name: @team.name,
        name_en: @team.name_en
      },
      date_integer: params[:date],
      select_players: res_select_players,
      selected_players: default_lineup_player_ids
    }
  end

  def create
    date = Date.parse(params[:date])
    team = Team.find(params[:team_id])
    game_comment = GameComment.create(
      team: team,
      date: params[:date],
      text: params[:text]
    )

    tweet_text = ''
    tweet_text << "#{game_comment.text}\r"
    request_url = "http://sports-memory.com/game_comment/#{team.name_en}/#{date.strftime('%Y%m%d')}"
    tweet_text << "\rもっと見る\r#{request_url} \r\r"
    tweet_text << "##{team.name} ##{date.strftime("%-m月%-d日")}の見所"
    
    twitter_client.update(tweet_text) if game_comment.text.size >= 8

    render json: { game_comment_text: game_comment.text }
  end
  
  private

  def default_lineup_player_ids
    if @daily_lineup_manage
      @daily_lineup_manage.daily_lineups.map{|lineup| lineup.batter_id}
    else
      OpeningStartingLineup::DefaultLineups.new(params[:team], @date.year + 1).lineup_player_ids
    end
  end

  def res_game_comment_texts
    @game_comments.map do |comment|
      comment.text
    end
  end

  def twitter_client
    TwitterClient.new
  end

  def res_batters
    return [] if @daily_lineup_manage.nil?
    @daily_lineup_manage.daily_lineups.map do |lineup|
      res_batter(lineup.batter)
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
