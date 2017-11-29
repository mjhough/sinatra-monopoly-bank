class AuctionsController < ApplicationController
    
    get "/auctions/new" do
        if logged_in?
            if !in_progress_auction
                @users = User.all
                erb :"auctions/new"
            else
                redirect "/auctions/#{in_progress_auction.id}"
            end
        else
            redirect "/login"
        end
    end

    post "/auctions/new" do
        auction = Auction.create
        auction.game = current_game
        auction.property = Property.find_or_create_by(params[:property])
        auction.save
        redirect "/auctions/#{auction.id}"
    end

    get "/auctions/:id" do
        if logged_in?
            @users = User.all
            @bidder = Bidder.find_by(user: current_user, auction: Auction.find(params[:id]))
            @auction = Auction.find(params[:id])
            @waiting_on = waiting_on
            if !auction_over?(@auction.id)
                erb :"auctions/show"
            else
                winning_bidder = Bidder.where(bid: @auction.highest_bid).first
                @winner = winning_bidder.user
                @auction.in_progress = false
                @auction.save
                if current_user == @winner
                    "Congratulations!"
                    # redirect "/auctions/winner"
                else
                    "Loser!"
                    # redirect "/auctions/loser" 
                end
            end
        else
            redirect "/login"
        end
    end

    post "/auctions/:id" do
        auction = Auction.find(params[:id])
        bidder = Bidder.find_by(user: current_user, auction: Auction.find(params[:id]))
        if !bidder
            bidder = Bidder.create(user: current_user, bid: params[:bid], auction: Auction.find(params[:id]))
        else
            bidder.update(bid: params[:bid])
        end
        if params[:bid].to_i > auction.highest_bid
            auction.highest_bid = params[:bid].to_i
        end
        auction.users << current_user
        auction.bidders << bidder
        auction.save
        bidder.save
        redirect "/auctions/#{auction.id}"
    end
end 