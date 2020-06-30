class DailyLineupManage < ActiveRecord::Base
  belongs_to :team
  has_many :daily_lineups

  class << self
    def create_by!(team_id:, date:, lineup:)
      transaction do
        daily_lineup_manage = find_or_create_by(
          team_id: team_id,
          date: date
        )
        daily_lineup_manage.daily_lineups.destroy_all
        lineup.each.with_index(1) do |batter_id, index|
          DailyLineup.create(
            daily_lineup_manage: daily_lineup_manage,
            batter_id: batter_id,
            order: index
          )
        end
        daily_lineup_manage.reload
      end
    end
  end
end
