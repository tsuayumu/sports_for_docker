require 'game_inning_service'

class GameController < ApplicationController
  def index
    @game = Game.find_or_create_by!(
      team: Team.team(params[:team]),
      date: Date.parse(params[:date])
    )
    GameInningService.new(@game).update

    render json: {
      inning_texts: inning_texts
    }
  end

  private

  def inning_texts
    result = []
    10.times.each do |inning|
      ['top', 'bottom'].each do |t_or_b|
        game_inning = @game.send("game_#{t_or_b}_#{IntegerConvertAlphabet.convert(inning+1)}_inning")
        if game_inning&.text.present?
          result << {
            inning: "#{inning+1}回#{top_or_bottom_string(t_or_b)}",
            text: game_inning.text.gsub(/\\n/, "\n"),
            updated_at: game_inning.created_at
          }
        end
      end
    end
    result
  end

  def top_or_bottom_string(t_or_b)
    if t_or_b == 'top'
      '表'
    else
      '裏'
    end
  end
end
