class LineupManage < ActiveRecord::Base
	belongs_to :team
	belongs_to :user
	has_many :lineup
	has_many :lineup_manage_user_comments

	scope :team, ->(team){ where(team_id: team) }
	scope :year, ->(year){ where(year: year) }

	delegate :name, to: :team, prefix: :team, allow_nil: true

	class << self
		def create_by!(team_id:, year:, comment:, lineup:)
			transaction do
				lineup_manage = create!(
					team_id: team_id,
					year: year,
					comment: comment
				)
				lineup.each.with_index(1) do |batter_id, index|
					Lineup.create(
						lineup_manage: lineup_manage,
						batter_id: batter_id,
						order: index
					)
				end
				lineup_manage.reload
			end
		end

		def team_lienups(team, year)
			team_id = Team.team_id(team)
			team(team_id).year(year)
		end
	end

	def lineups
		lineup
	end

	def tweet_text(request_url:, line_code:)
		result = ''
		result << "#{comment}#{line_code}#{line_code}" if comment.present?
		lineup.each.with_index(1) do |l, i|
			result << "#{i}番　#{l.name}#{line_code}"
		end
		result << "#{line_code}詳しくはこちら#{line_code}#{request_url} #{line_code}#{line_code}"
		result << "##{team_name} ##{year}開幕スタメン"
		result
	end
end
