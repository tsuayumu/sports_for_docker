class RotationManageController < ApplicationController
  before_action :permit_all_parameters, only: [:create]

  def index
    @team = Team.team(params[:team])
    @year = params[:year]
    @rotation_form = RotationForm.new
    @default_rotations = DefaultRotations.new(params[:team], params[:year])
    @rotation_manages = RotationManage.team(@team).year(@year).reverse
    @select_players = Pitcher.name_and_id_by(@team.id, @year)
  end

  def create
    form = RotationForm.new(params[:rotation_form])
    form.save
    twitter_client.update(form.rotation_manage.tweet_text(request_url: request.url, line_code: '\r'))
		redirect_to :index_rotation_manage
  end

  private

  def permit_all_parameters
		# strong_parameterが解決できないため暫定対応
		ActionController::Parameters.permit_all_parameters = true
  end
  
  def twitter_client
		TwitterClient.new
	end
end
