class RotationManageController < ApplicationController
  def index
    @team = Team.team(params[:team])
    @year = params[:year]
    @rotation_form = RotationForm.new
    @rotation_manages = RotationManage.team(@team).year(@year).reverse
    @select_players = Pitcher.name_and_id_by(@team.id, @year)
  end

  def create
    @form = RotationForm.new(params[:rotation_form])
		@form.save
		redirect_to :index_rotation_manage
  end
end
