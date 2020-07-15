class Batter < ActiveRecord::Base
	has_one :batter_record
	has_many :lineup
	belongs_to :team

	scope :by_prefix_match_name, ->(name, year){ where(year: year).where("REPLACE(name,'　','') like ?","#{name}%") }
end
