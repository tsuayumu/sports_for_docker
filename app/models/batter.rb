class Batter < ActiveRecord::Base
	has_one :batter_record
	has_many :lineup
	belongs_to :team

	class << self
		def name_and_id_by(team, year)
			name_and_id = []
			batters = where(team_id: team, year: year)
			batters.each do |b|
				name_and_id << [b.name, b.id]
			end
			name_and_id
		end
	end
end
