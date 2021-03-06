class AuctionsController < ApplicationController
    
    get "/auctions/new" do
        if logged_in? && game_exists?
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
        if params[:property].all? {|param, value| !value.strip.empty?}
            auction = Auction.create
            auction.game = current_game
            property = Property.find_or_create_by(params[:property]) # Creates a property with a name and rent.
            payment = Payment.create(auction: auction, game: current_game)
            auction.property = property
            auction.payment = payment
            auction.save
            property.game = current_game
            property.auction = auction
            property.save
            redirect "/auctions/#{auction.id}"
        else
            flash[:error] = "Please fill in all fields."
            redirect "/auctions/new"
        end
    end

    get "/auctions/winner" do
        @property = Property.last
        if logged_in? && @property == current_user.properties.last
            @users = User.where(game_id: current_game.id)
            erb :"auctions/winner"
        else
            redirect "/game"
        end
    end

    get "/auctions/loser" do
        if logged_in? && game_exists?
            @users = User.where(game_id: current_game.id)
            @property = Property.last
            erb :"auctions/loser"
        else
            redirect "/login"
        end
    end

    get "/auctions/:id" do
        if logged_in? && game_exists?
            @users = User.where(game_id: current_game.id)
            @bidder = Bidder.find_by(user: current_user, auction: Auction.find(params[:id]))
            @auction = Auction.find(params[:id])
            @waiting_on = waiting_on
            if !auction_over?(@auction.id)
                erb :"auctions/show"
            else
                winning_bidder = Bidder.find_by(bid: @auction.highest_bid)
                @winner = winning_bidder.user
                @auction.in_progress = false
                @auction.save
                if current_user == @winner
                    property = Property.find_by(auction: @auction)
                    property.user = @winner
                    property.price = @auction.highest_bid

                    payment = Payment.find_by(auction: @auction)
                    payment.update(payee_account: User.find_by(name: "Bank").account_number, payer_account: @winner.account_number, amount: @auction.highest_bid, description: "AUCTION: For #{property.name}.", property: property)
                    payment.users << @winner
                    payment.users << User.find_by(name: "Bank")
                    
                    
                    payment.save
                    property.save
                    
                    @winner.balance -= @auction.highest_bid
                    @winner.save

                    session[:bid_placed] = nil
                    redirect "/auctions/winner"
                else
                    session[:bid_placed] = nil
                    redirect "/auctions/loser" 
                end
            end
        else
            redirect "/login"
        end
    end

    post "/auctions/:id" do
        @auction = Auction.find(params[:id])
        if !session[:bid_placed]
            if params.all? {|param, value| !value.strip.empty?}
                if sufficient_balance?(params[:bid].to_i)
                    if !bid_taken?
                        bidder = Bidder.find_by(user: current_user, auction: @auction)
                        if !bidder
                            bidder = Bidder.create(user: current_user, bid: params[:bid], auction: @auction)
                        else
                            bidder.update(bid: params[:bid])
                        end

                        user = current_user
                        user.bidder = bidder
                        user.save

                        if current_user.bidder.bid > @auction.highest_bid
                            @auction.highest_bid = current_user.bidder.bid
                        end

                        @auction.users << current_user
                        @auction.bidders << bidder
                        @auction.save
                        session[:bid_placed] = true
                        redirect "/auctions/#{@auction.id}"
                    else
                        flash[:error] = "Pick another number. That one is taken ;)"
                        redirect "/auctions/#{params[:id]}"
                    end
                else
                    flash[:error] = "You're too broke to splash that amount of cash."
                    redirect "/auctions/#{params[:id]}"
                end
            else
                flash[:error] = "If you don't want this property place a bid for $0."
                redirect "/auctions/#{params[:id]}"
            end
        elsif session[:bid_placed] && !auction_over?(@auction.id)
            flash[:error] = "You may only bid once."
            redirect "/auctions/#{@auction.id}"
        end
    end

    get "/auctions/:id/delete" do
        if logged_in? 
            auction = Auction.find(params[:id])
            auction.bidders.destroy_all
            auction.property.destroy
            auction.payment.destroy
            auction.destroy
            redirect "/game"
        else
            redirect "/login"
        end
    end
end 