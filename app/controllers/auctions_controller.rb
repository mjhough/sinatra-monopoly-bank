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
                    property = Property.where(auction: @auction).first
                    property.rent = params[:property][:rent].to_i
                    property.price = payment_amount
                    property.user = payer
                    property.game = current_game
                    property.save

                payment = Payment.create(params[:payment])
                payment.property = property if property
                payment.users << payer
                payment.users << pay_to
                payment.game = current_game
                payment.save
                pay_to.balance += payment_amount
                pay_to.save
                payer.balance -= payment_amount
                payer.save

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
        property = Property.find_or_create_by(params[:property])
        payment = Payment.find_or_create_by(payer_account: current_user.account_number, amount: auctions.highest_bid, description: "AUCTION: For #{property.name}.")
        property.auction = auction
        payment.auction = auction
        property.save
        payment.save
        redirect "/auctions/#{auction.id}"
    end
end 