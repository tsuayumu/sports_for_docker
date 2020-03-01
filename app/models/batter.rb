class Batter < ActiveRecord::Base
	has_one :batter_record
	has_many :lineup
	belongs_to :team
end
