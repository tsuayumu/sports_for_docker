class RankingController < ApplicationController
	def index
		@league = League.league(params[:league])
		@ranking_manages = RankingManage.rankings(params[:league], params[:year]).reverse
		@year = params[:year]

		render json: res_index
	end

	def create
		ranking_manage = RankingManage.create_by(
			year: params[:year],
			league_id: params[:league_id],
			ranking: params[:ranking]
		)

		tweet_text = ''
		ranking_manage.ranking.each.with_index(1) do |r, i|
			tweet_text << "#{i}位　#{r.team_name}\r"
		end
		request_url = "http://sports-memory.com/ranking/#{ranking_manage.league_name_en}/#{ranking_manage.year}"
		tweet_text << "\r詳しくはこちら\r#{request.url} \r\r"
		tweet_text << "##{ranking_manage.year}#{ranking_manage.league_name}順位予想"

		twitter_client.update(tweet_text)

		render json: {
			rankings: res_ranking_manage(ranking_manage)
		}
	end

	private

	def twitter_client
		TwitterClient.new
	end

	def res_index
		{
			league: {
				id: @league.id,
				name: @league.name,
				name_en: @league.name_en
			},
			year: @year,
			selected_teams: res_selected_teams,
			select_teams: res_select_teams,
			ranking_manages: res_ranking_manages
		}
	end

	def res_selected_teams
		if @league.id == 1
			[1,2,3,4,5,6]
		else
			[7,8,9,10,11,12]
		end
	end

	def res_select_teams
		@league.teams.map do |t|
			{
				id: t.id,
				name: t.name
			}
		end
	end

	def res_ranking_manages
		@ranking_manages.map do |ranking_manage|
			{
				rankings: res_ranking_manage(ranking_manage)
			}
		end
	end

	def res_ranking_manage(ranking_manage)
		ranking_manage.ranking.map do |r|
			{
				name: r.team_name
			}
		end
	end
end
