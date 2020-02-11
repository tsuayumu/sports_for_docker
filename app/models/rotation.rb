class Rotation < ActiveRecord::Base
  belongs_to :rotation_manage
  belongs_to :pitcher

  delegate :name, to: :pitcher, allow_nil: true
end
