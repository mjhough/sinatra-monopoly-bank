class UsersController < ApplicationController

    get "/signup" do
        if !logged_in?
            erb :"users/signup"
        else
            redirect "/"
        end
    end

    post "/signup" do
        if params.all? {|param, value| !value.empty?}
            if !username_exists?(params[:username])
                user = User.create(params)
                session[:user_id] = user.id
                redirect "/"
            else
                flash[:error] = "That username is taken."
                redirect "/signup"
            end
        else
            flash[:error] = "Please fill in all the boxes."
            redirect "/signup"
        end
    end

    get "/login" do
        if !logged_in?
            erb :"users/login"
        else
            redirect "/"
        end
    end

    post "/login" do
        if params.all? {|param, value| !value.empty?}
            user = User.find_by(username: params[:username])
            if user && user.authenticate(params[:password])
                session[:user_id] = user.id
                redirect "/"
            else
                flash[:error] = "Username or password not found."
                redirect "/login"
            end
        else
            flash[:error] = "Please fill in all the boxes."
            redirect "/login"
        end
    end

    get "/logout" do
        if logged_in?
            session.clear
            redirect "/"
        else
            redirect "/login"
        end
    end

    get "/users/:id" do
        if logged_in?
            @users = User.where(game: current_game)
            @user = User.find(params[:id])
            erb :"users/show"
        else
            redirect "/login"
        end
    end
end