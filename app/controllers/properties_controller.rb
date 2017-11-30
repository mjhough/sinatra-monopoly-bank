class PropertiesController < ApplicationController

    get "/properties" do
        @users = User.where(game: current_game)
        @properties = Property.where(game: current_game)
        erb :"properties/index"
    end

    get "/properties/:id/payments" do
        @users = User.where(game: current_game)
        @payments = Payment.where(property: Property.find(params[:id]))
        erb :"properties/payments_show"
    end

    get "/properties/:id/" do
        @users = User.where(game: current_game)
        @property = Property.find(params[:id])
        erb :"properties/show"
    end
end