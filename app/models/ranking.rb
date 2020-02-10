class Ranking < ActiveRecord::Base
	belongs_to :ranking_manage
	belongs_to :team

	delegate :name, to: :team, prefix: :team, allow_nil: true
end
