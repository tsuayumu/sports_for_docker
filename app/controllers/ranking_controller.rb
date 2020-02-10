class RankingController < ApplicationController
	before_action :permit_all_parameters, only: [:create]

	def index
		@league = League.league(params[:league])
		@ranking_manages = RankingManage.rankings(params[:league], params[:year]).reverse
		@ranking_form = RankingForm.new
		@select_teams = teams_for_select_form(@league)
		@year = params[:year]
	end

	def create
		@form = RankingForm.new(params[:ranking_form])
		@form.save
		session["create_ranking_#{@form.league_id}"] = true
		redirect_to :index_ranking
	end

	private

	def teams_for_select_form(league)
		team_and_id = []
		league.teams.each do |team|
			team_and_id << [team.name, team.id]
		end
		team_and_id
	end

	def permit_all_parameters
		# strong_parameterが解決できないため暫定対応
		ActionController::Parameters.permit_all_parameters = true
	end
end
