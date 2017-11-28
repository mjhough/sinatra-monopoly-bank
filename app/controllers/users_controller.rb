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
            user = User.create(params)
            session[:user_id] = user.id
            redirect "/"
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
        session.clear
        redirect "/"
    end
end