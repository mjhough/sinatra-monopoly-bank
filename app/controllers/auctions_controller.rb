class AuctionsController < ApplicationController
    
    get "/auctions/new" do
        @users = User.all
        erb :"auctions/new"
    end

    post "/auctions/new" do
        raise params.inspect
    end
end 