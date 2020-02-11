class RankingManage < ActiveRecord::Base
	has_many :ranking
	belongs_to :league
	accepts_nested_attributes_for :ranking

	delegate :name, to: :league, prefix: :league, allow_nil: true

	class << self
		def rankings(league, year)
			league_id = League.league_id(league)
			where(league_id: league_id).where(year: year)
		end
	end
end
