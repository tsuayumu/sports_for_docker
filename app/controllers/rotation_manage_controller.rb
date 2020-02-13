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
    rotation_manage = form.rotation_manage
		tweet_text = ''
		tweet_text << "#{rotation_manage.comment}\r\r" if rotation_manage.comment.present?
		rotation_manage.rotations.each.with_index(1) do |l, i|
      if i == 1
        tweet_text << "【先発】\r"
      elsif i == 7
        tweet_text << "\r【中継ぎ】\r"
      elsif i == 10
        tweet_text << "\r【抑え】\r"
      end
      tweet_text << "#{l.name}\r"
		end
		tweet_text << "\r詳しくはこちら\r#{request.url} \r\r"
		tweet_text << "##{rotation_manage.team_name} ##{rotation_manage.year}開幕ローテーション"

		twitter_client.update(tweet_text)
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
