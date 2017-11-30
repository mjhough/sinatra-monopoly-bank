class PropertiesController < ApplicationController

    get "/properties" do
        if logged_in? 
            @users = User.where(game: current_game)
            @properties = Property.where(game: current_game)
            erb :"properties/index"
        else
            redirect "/login"
        end
    end

    get "/properties/:id" do
        if logged_in?
            @users = User.where(game: current_game)
            @property = Property.find(params[:id])
            erb :"properties/show"
        else
            redirect "/login"
        end
    end

    get "/properties/:id/payments" do
        if logged_in?
            @users = User.where(game: current_game)
            @payments = Payment.where(property: Property.find(params[:id]))
            erb :"properties/payments_show"
        else
            redirect "/login"
        end
    end
end