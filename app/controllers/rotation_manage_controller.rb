class RotationManageController < ApplicationController
  def index
    @team = Team.team(params[:team])
    @year = params[:year]
    @default_rotations = DefaultRotations.new(params[:team], params[:year])
    @rotation_manages = RotationManage.team(@team).year(@year).reverse
    @select_pitchers = Pitcher.where(team_id: @team.id, year: @year)

    render json: res_index_json
  end

  def create
    rotation_manage = RotationManage.create_by!(
			team_id: params[:team_id],
			year: params[:year],
			comment: params[:comment],
			rotation: params[:rotation]
		)

		tweet_text = ''
		tweet_text << "#{rotation_manage.comment}\r\r" if rotation_manage.comment.present?
		rotation_manage.rotations.each.with_index(1) do |l, i|
      if i == 1
        tweet_text << "【先発】\r"
      elsif i == 7
        tweet_text << "\r【中継ぎ】\r"
      elsif i == 10
        tweet_text << "\r【抑え】\r"
      end
      tweet_text << "#{l.name}\r"
    end
    request_url = "https://sports-memory.com/opening_rotation/#{rotation_manage.team_name_en}/#{rotation_manage.year}"
		tweet_text << "\r詳しくはこちら\r#{request_url} \r\r"
		tweet_text << "##{rotation_manage.team_name} ##{rotation_manage.year}開幕ローテーション"

		twitter_client.update(tweet_text)
    
    render json: res_rotation_manage(rotation_manage)
  end

  private

  def res_rotation_manage(rotation_manage)
		{
			id: rotation_manage.id,
			rotations: res_rotations(rotation_manage),
			comment: rotation_manage.comment,
			user_comments: res_user_comments(rotation_manage)
		}
  end

  def res_rotations(rotation_manage)
		rotation_manage.rotations.map do |r|
			pitcher = r.pitcher
			res_pitcher(pitcher)
		end
	end
  
  def res_user_comments(rotation_manage)
		rotation_manage.rotation_manage_user_comments.map do |user_comment|
			user_comment.comment
		end
	end
  
  def twitter_client
		TwitterClient.new
  end
  
  def res_index_json
    {
      year: @year,
      team: {
        id: @team.id,
        name: @team.name,
        name_en: @team.name_en
      },
			league: {
				name_en: @team.league&.name_en || 'central'
			},
      selected_players: @default_rotations.pitcher_ids,
      select_players: res_select_players,
      rotation_manages: res_rotation_manages
    }
  end

  def res_rotation_manages
    @rotation_manages.map do |rotation_manage|
			res_rotation_manage(rotation_manage)
		end
  end

  def res_select_players
		@select_pitchers.map do |p|
			res_pitcher(p)
		end
  end
  
  def res_pitcher(pitcher)
    {
      pitcher_id: pitcher.id,
      name: pitcher.name.gsub(/\p{blank}/," "),
      match: pitcher.pitcher_record&.match,
      era: pitcher.pitcher_record&.era,
      win: pitcher.pitcher_record&.win,
      defeat: pitcher.pitcher_record&.defeat,
      hold: pitcher.pitcher_record&.hold,
      save_point: pitcher.pitcher_record&.save_point
    }
	end
end
