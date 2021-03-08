require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if logged_in?
      redirect :'/profile'
    end
    erb :index
  end

  def current_user
    @user = User.find_by(id: session[:user_id])
  end

  def logged_in?
      session.key?(:user_id)
  end

  def redirect_if_not_logged_in
    redirect '/login' unless current_user
end

  def profile?
    profile_id = params[:id].to_i
    logged_in? && profile_id == session[:user_id]
  end

  def set_workout
    @workout = Workout.find_by(id: params[:id])
  end
end
