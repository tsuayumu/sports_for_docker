class LineupManage < ActiveRecord::Base
	belongs_to :team
	belongs_to :user
	has_many :lineup
	has_many :lineup_manage_user_comments
	has_one :lineup_manage_like

	scope :team, ->(team){ where(team_id: team) }
	scope :year, ->(year){ where(year: year) }

	delegate :name, :name_en, :year, to: :team, prefix: :team, allow_nil: true
	delegate :count, to: :lineup_manage_like, prefix: :like, allow_nil: true

	class << self
		def create_by!(team_id:, year:, comment:, lineup:)
			transaction do
				lineup_manage = create!(
					team_id: team_id,
					year: year,
					comment: comment
				)

				# 重複する打順を検査するため（SQL1つで書けそう）
				already_registered_count = 0
				lineup.each.with_index(1) do |batter_id, index|
					already_registered_count += 1 if Lineup.where(batter_id: batter_id, order: index).present?
					Lineup.create(
						lineup_manage: lineup_manage,
						batter_id: batter_id,
						order: index
					)
				end
				raise AlreadyRegisteredError if already_registered_count == 9

				lineup_manage.reload
			end
		end

		def team_lienups(team, year)
			team_id = Team.team_id(team)
			team(team_id).year(year)
		end
	end

	def like!
		like = LineupManageLike.find_or_create_by(lineup_manage: self)
		like.count = like.count + 1
		like.save!
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

	class AlreadyRegisteredError < StandardError; end
end
