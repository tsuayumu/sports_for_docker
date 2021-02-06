class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :valid_parameter

  private
  def current_user
  	if session[:user_id]
  		@current_user ||= User.find_by(id: session[:user_id])
  	end
  end
  helper_method :current_user

  def valid_parameter
    if params[:team].present?
      raise unless params[:team] =~ Team.name_regexp_for_routing
    end
    if params[:year].present?
      raise unless params[:year] =~ /(2017|2018|2019|2020|2021)/
    end
    if params[:league].present?
      raise unless params[:league] =~ League.league_regexp_for_routing
    end
  end
end
