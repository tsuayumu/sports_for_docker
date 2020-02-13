require 'twitter_client'

class OpeningStartingLineupController < ApplicationController
	before_action :permit_all_parameters, only: [:create, :create_comment]

	def index
		@team = Team.team(params[:team])
		@year = params[:year]
		@lineup_form = OpeningStartingLineupForm.new(default_lineup.lineup)
		@opening_lineups = LineupManage.team_lienups(params[:team], params[:year]).reverse
		@comment_form = OpeningStartingLineupCommentForm.new
		@select_players = select_batter_by_default_sort
	end

	def create
		form = OpeningStartingLineupForm.new(params[:opening_starting_lineup_form])
		form.save
		twitter_client.update(form.lineup_manage.tweet_text(request_url: request.url, line_code: '\r'))
		redirect_to :index_opening_starting_lineup
	end

	def create_comment
		@form = OpeningStartingLineupCommentForm.new(params[:opening_starting_lineup_comment_form])
		@form.save
		redirect_to :index_opening_starting_lineup
	end

	private

	def default_lineup
		OpeningStartingLineup::DefaultLineups.new(params[:team], @year)
	end

	def permit_all_parameters
		# strong_parameterが解決できないため暫定対応
		ActionController::Parameters.permit_all_parameters = true
	end

	def select_batter_by_default_sort
		batters = Batter.name_and_id_by(@team.id, @year)
		sort_batters = batters.select do |p|
			default_lineup.lineup_player_ids.include?(p[1])
		end
		(sort_batters + batters).uniq{|p| p[1]}
	end

	def twitter_client
		TwitterClient.new
	end
end
