class GameHighlightController < ApplicationController
  def index
    date = Date.parse(params[:date])
    team = Team.team(params[:team])
    @highlights = team.game_highlights.where(date: date)

    render json: {
      date: date.strftime("%Y/%m/%d"),
      highlight_texts: res_highlight_texts,
      team: {
        id: team.id,
        name: team.name,
        name_en: team.name_en
      },
      date_integer: params[:date]
    }
  end

  def create
    date = Date.parse(params[:date])
    team = Team.find(params[:team_id])
    highlight = GameHighlight.create(
      team: team,
      date: params[:date],
      text: params[:text]
    )

    tweet_text = ''
    tweet_text << "#{highlight.text}\r"
    request_url = "http://sports-memory.com/game_highlight/#{team.name_en}/#{params[:date]}"
    tweet_text << "\rもっと見る\r#{request_url} \r\r"
    tweet_text << "##{team.name} ##{date.strftime("%-m月%-d日")}の見所"
    
    twitter_client.update(tweet_text) if highlight.text.size >= 8

    render json: { highlight_text: highlight.text }
  end
  
  private

  def res_highlight_texts
    @highlights.map do |highlight|
      highlight.text
    end
  end

  def twitter_client
    TwitterClient.new
  end
end
