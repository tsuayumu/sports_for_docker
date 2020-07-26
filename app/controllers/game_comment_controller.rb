require 'twitter_client'

class GameCommentController < ApplicationController
  def index
    @date = Date.parse(params[:date])
    @team = Team.team(params[:team])
    @game_comments = @team.game_comments.where(date: @date)

    render json: {
      date: @date.strftime("%Y/%m/%d"),
      game_comment_texts: res_game_comment_texts,
      team: {
        id: @team.id,
        name: @team.name,
        name_en: @team.name_en
      }
    }
  end

  def create
    date = Date.parse(params[:date])
    team = Team.find(params[:team_id])

    if params[:text] =~ /^ツイート/
      twitter_client.search(params[:text].delete("ツイート")).take(5).each do |tw|
        begin
          GameComment.create!(
            team: team,
            date: params[:date],
            text: tw.full_text
          )
        rescue ActiveRecord::StatementInvalid
        end
      end

      render json: {
        text: GameComment.last.text,
        comment_at: GameComment.last.created_at
      }
    else
      game_comment = GameComment.create!(
        team: team,
        date: params[:date],
        text: params[:text]
      )

      tweet_text = ''
      tweet_text << "#{game_comment.text}\r"
      request_url = "https://sports-memory.com/game/#{team.name_en}/#{date.strftime('%Y%m%d')}"
      tweet_text << "\rもっと見る\r#{request_url} \r\r"
      tweet_text << "##{team.name} ##{date.strftime("%-m月%-d日")}の試合中コメント"

      twitter_client.update(tweet_text) if game_comment.text.size >= 8

      render json: {
        text: game_comment.text,
        comment_at: game_comment.created_at
      }
    end
  end
  
  private

  def res_game_comment_texts
    @game_comments.map do |comment|
      {
        text: comment.text,
        comment_at: comment.created_at
      }
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
end
