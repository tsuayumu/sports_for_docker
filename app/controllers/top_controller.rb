class TopController < ApplicationController
	def index
		@central_teams = League.central_teams
		@pacific_teams = League.pacific_teams

		render json: res_json
	end

	private

	def res_json
		{
			central: res_teams(@central_teams),
			pacific: res_teams(@pacific_teams)
		}
	end

	def res_teams(teams)
		teams.map do |t|
			{
				name: t.name,
				name_en: t.name_en,
				league: t.league_id
			}
		end
	end
end
