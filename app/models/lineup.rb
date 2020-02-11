class Lineup < ActiveRecord::Base
	belongs_to :lineup_manage
	belongs_to :batter

	delegate :name, to: :batter, allow_nil: true
end
