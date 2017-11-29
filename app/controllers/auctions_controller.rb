class AuctionsController < ApplicationController
    
    get "/auctions/new" do
        @users = User.all
        erb :"auctions/new"
    end

    post "/auctions/new" do
        auction = Auction.create
        auction.game = current_game
        auction.property = Property.find_or_create_by(params[:property])
        auction.save
        redirect "/auctions/#{auction.id}"
    end

    get "/auctions/:id" do
        @users = User.all
        @bidder = Bidder.find_by(user: current_user, auction: Auction.find(params[:id]))
        @auction = Auction.find(params[:id])
        users_in_auction = User.where(auction: @auction)
        users_in_game = User.where(game: current_game)
        @waiting_on = users_in_game - users_in_auction
        erb :"auctions/show"
    end

    post "/auctions/:id" do
        auction = Auction.find(params[:id])
        bidder = Bidder.find_by(user: current_user, auction: Auction.find(params[:id]))
        if !bidder
            bidder = Bidder.create(user: current_user, bid: params[:bid], auction: Auction.find(params[:id]))
        else
            bidder.update(bid: params[:bid])
        end
        auction.users << current_user
        auction.bidders << bidder
        auction.save
        bidder.save
        redirect "/auctions/#{auction.id}"
    end
end 