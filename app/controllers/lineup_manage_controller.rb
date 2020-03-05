require 'twitter_client'

class LineupManageController < ApplicationController
	def index
		@team = Team.team(params[:team])
		@year = params[:year]
		@opening_lineups = LineupManage.team_lienups(params[:team], params[:year]).reverse
		@select_batters = select_batter_by_default_sort

		render json: res_index_json
	end

	def create
		lineup_manage = LineupManage.create_by!(
			team_id: params[:team_id],
			year: params[:year],
			comment: params[:comment],
			lineup: params[:lineup]
		)

		tweet_text = ''
		tweet_text << "#{lineup_manage.comment}\r\r" if lineup_manage.comment.present?
		lineup_manage.lineup.each.with_index(1) do |l, i|
			tweet_text << "#{i}番　#{l.name}\r"
		end
		tweet_text << "\r詳しくはこちら\r#{request.url} \r\r"
		tweet_text << "##{lineup_manage.team_name} ##{lineup_manage.year}開幕スタメン"

		twitter_client.update(tweet_text)

		render json: res_lineup_manage(lineup_manage)
	end

	private

	def default_lineup
		OpeningStartingLineup::DefaultLineups.new(params[:team], @year)
	end

	def select_batter_by_default_sort
		batters = Batter.where(team_id: @team.id, year: @year)
		sort_batters = batters.select do |b|
			default_lineup.lineup_player_ids.include?(b.id)
		end
		(sort_batters + batters).uniq{|b| b.id}
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
				name_en: @team.league.name_en
			},
			selected_players: default_lineup.lineup_player_ids,
			select_players: res_select_players,
			lineup_manages: res_lineup_manages
		}
	end

	def res_select_players
		@select_batters.map do |b|
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

	def res_lineup_manages
		@opening_lineups.map do |lineup_manage|
			res_lineup_manage(lineup_manage)
		end
	end

	def res_lineup_manage(lineup_manage)
		{
			id: lineup_manage.id,
			lineups: res_lineups(lineup_manage),
			comment: lineup_manage.comment,
			user_comments: res_user_comments(lineup_manage)
		}
	end

	def res_lineups(lineup_manage)
		lineup_manage.lineup.map do |line|
			batter = line.batter
			res_batter(batter)
		end
	end

	def res_user_comments(lineup_manage)
		lineup_manage.lineup_manage_user_comments.map do |user_comment|
			user_comment.comment
		end
	end
end
