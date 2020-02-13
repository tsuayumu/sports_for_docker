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

	def tweet_text(request_url:, line_code:)
		result = ''
		ranking.each.with_index(1) do |r, i|
			result << "#{i}位　#{r.team_name}#{line_code}"
		end
		result << "#{line_code}詳しくはこちら#{line_code}#{request_url} #{line_code}#{line_code}"
		result << "##{year}#{league_name}順位予想"
		result
	end
end
