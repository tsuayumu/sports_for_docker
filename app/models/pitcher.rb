class Pitcher < ActiveRecord::Base
	has_one :pitcher_record
  belongs_to :team
  has_many :rotations

  class << self
		def name_and_id_by(team, year)
			name_and_id = []
			pitchers = where(team_id: team, year: year)
			pitchers.each do |b|
				name_and_id << [b.name, b.id]
			end
			name_and_id
		end
	end
end
