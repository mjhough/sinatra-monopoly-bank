class AuctionsController < ApplicationController
    
    get "/auctions/new" do
        if logged_in?
            if !in_progress_auction
                @users = User.where(game_id: current_game.id)
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
        property = Property.find_or_create_by(params[:property]) # Creates a property with a name and rent.
        auction.property = property
        auction.save
        property.auction = auction
        property.save
        redirect "/auctions/#{auction.id}"
    end

    get "/auctions/winner" do
        @users = User.where(game_id: current_game.id)
        @property = Property.last
        erb :"auctions/winner"
    end

    get "/auctions/loser" do
        @users = User.where(game_id: current_game.id)
        @property = Property.last
        erb :"auctions/loser"
    end

    get "/auctions/:id" do
        if logged_in?
            @users = User.where(game_id: current_game.id)
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
                    property.user = @winner
                    property.game = current_game
                    property.price = @auction.highest_bid

                    payment = Payment.where(auction: @auction).first
                    payment.property = property
                    payment.users << @winner
                    payment.users << User.find_by(name: "bank")
                    payment.game = current_game
                    payment.save
                    property.save
                    
                    @winner.balance -= @auction.highest_bid
                    @winner.save

                    redirect "/auctions/winner"
                else
                    redirect "/auctions/loser" 
                end
            end
        else
            redirect "/login"
        end
    end

    post "/auctions/:id" do # PROBLEM. PARAMS => {"bid"=>"9000000", "id"=>"17"}
        raise params.inspect
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
        property = Property.find_or_create_by(params[:property]) # PROBLEM CODE!
        payment = Payment.find_or_create_by(payee_account: User.find_by(name: "bank").account_number, payer_account: current_user.account_number, amount: auction.highest_bid, description: "AUCTION: For #{property.name}.")
        property.auction = auction
        payment.auction = auction
        property.save
        payment.save
        redirect "/auctions/#{auction.id}"
    end
end 