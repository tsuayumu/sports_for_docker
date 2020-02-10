class RotationForm
	include ActiveModel::Model

	attr_accessor :team_id, :year, :rotations, :comment

	def save
		rotation_manage = RotationManage.new(team_id: team_id, year: year, comment: comment, rotations_attributes: rotations)
		rotation_manage.save!
	end
end
