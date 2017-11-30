require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  include Helpers::InstanceMethods
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "shush, it's a secret"
  end

  get "/" do
    erb :index
  end

  get "/game/new" do
    if logged_in?
      clear_game
      Game.create
      redirect "/game"
    else
      redirect "/"
    end
  end

  get "/game" do
    if logged_in?
      @game = current_game
      @game.users << current_user if !@game.users.include?(current_user)
      @users = User.where(game_id: @game.id)
      @payments = Payment.where(game_id: current_game)
      erb :"game/index"
    else
      redirect "/login"
    end
  end

  get "/settings" do
    if logged_in? && game_exists?
      @users = User.where(game: current_game)
      erb :"game/settings"
    else
      redirect "/login"
    end
  end

  patch "/settings" do
    if params[:settings].all? {|setting, value| !value.empty?}
      User.update(params[:settings])
      redirect "/game"
    else
      flash[:error] = "Please don't leave the form blank."
      redirect "/settings"
    end
  end
end