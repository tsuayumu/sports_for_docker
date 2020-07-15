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

    def create_by_prefix_match_name!(team_id:, date:, names:)
      transaction do
        daily_lineup_manage = find_or_create_by(
          team_id: team_id,
          date: date
        )
        names.each.with_index(1) do |name, index|
          DailyLineup.create(
            daily_lineup_manage: daily_lineup_manage,
            batter_id: daily_lineup_manage.team.batters.by_prefix_match_name(name, date.year+1).take&.id,
            order: index
          )
        end
      end
    end
  end
end
