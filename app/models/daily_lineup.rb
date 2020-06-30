class DailyLineup < ActiveRecord::Base
  belongs_to :daily_lineup_manage
  belongs_to :batter

  delegate :name, to: :batter, allow_nil: true
end
