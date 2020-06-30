class DailyLineupManage < ActiveRecord::Base
	belongs_to :team  
	has_many :daily_lineup
end
