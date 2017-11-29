class AuctionsController < ApplicationController
    
    get "/auctions/new" do
        @users = User.all
        erb :"auctions/new"
    end

    post "/auctions/new" do
        raise params.inspect
        auction = Auction.create(params[:auction])
        auction.game = current_game
        auction.property = Property.find_or_create_by(params[:property])
        auction.start
        redirect "/auctions/#{auction.id}"
    end
end 