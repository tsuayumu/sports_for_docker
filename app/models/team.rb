class Team < ActiveRecord::Base
  has_many :opening_starting_lineup
  belongs_to :league
  has_many :lineup_manages
  has_many :rotation_manages
  has_many :rankings
  has_many :game_highlights
  has_many :game_comments

  scope :team_id, ->(name_en){ find_by(name_en: name_en).id}
  scope :team, ->(name_en){ find_by(name_en: name_en) }

  class << self
    def all_teams
      all
    end

    def all_teams_name
      pluck(:name_en)
    end

    def name_regexp_for_routing
      Regexp.union(self.all_teams_name)
    end
  end

  def giants?
    id == 1
  end

  def tigers?
    id == 2
  end

  def swallows?
    id == 3
  end

  def carp?
    id == 4
  end

  def baystars?
    id == 5
  end

  def dragons?
    id == 6
  end

  def hawks?
    id == 7
  end

  def fighters?
    id == 8
  end

  def buffaloes?
    id == 9
  end

  def marines?
    id == 10
  end

  def eagles?
    id == 11
  end

  def lions?
    id == 12
  end
end
