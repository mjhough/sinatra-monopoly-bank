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

end