require 'game_inning_service'

class GameController < ApplicationController
  def index
    @game = Game.find_or_create_by!(
      team: Team.team(params[:team]),
      date: Date.parse(params[:date])
    )
    GameInningService.new(@game).update

    render json: {
      date: @date.strftime("%Y/%m/%d"),
      inning_texts: inning_texts
    }
  end

  private

  def inning_texts
    result = []
    10.times.each do |inning|
      ['top', 'bottom'].each do |t_or_b|
        game_inning = @game.send("game_#{t_or_b}_#{IntegerConvertAlphabet.convert(inning+1)}_inning")
        if game_inning.text.present?
          result << {
            text: game_inning.text,
            updated_at: game_inning.updated_at
          }
        end
      end
    end
    result
  end
end
