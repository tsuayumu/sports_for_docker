class RotationManage < ActiveRecord::Base
  has_many :rotation_comments
  has_many :rotations
  belongs_to :team
  accepts_nested_attributes_for :rotations

  scope :team, ->(team){ where(team_id: team.id) }
  scope :year, ->(year){ where(year: year) } 
  
  delegate :name, to: :team, prefix: :team, allow_nil: true
end
