module Helpers
    module InstanceMethods
        def logged_in?
            !!session[:user_id]
        end

        def game_exists?
            !Game.all.empty?
        end

        def current_user
            User.find_by_id(session[:user_id])
        end

        def current_game
            Game.last
        end

        def clear_game
            if game_exists?
                User.all.each do |user|
                    user.balance = 15000000
                    user.save
                end
                Auction.destroy_all
                Property.destroy_all
                Payment.destroy_all
                Game.destroy_all
                Bidder.destroy_all

                User.create(name: "Bank", username: "bank", password: "do! not! login! with! this! account!", account_number: rand(10**10).to_s)
            end
        end

        def auction_over?(auction_id)
            auction = Auction.find(params[:id])
            waiting_on.empty?
        end

        def waiting_on
            User.where.not(auction: @auction).or(User.where(auction: nil)).where(game: current_game)
        end

        def in_progress_auction
            Auction.where(in_progress: true).first
        end

        def is_bank?(payee_account)
            payee_account.downcase == "bank"
        end

        def sufficient_balance?(balance_input)
            balance_input <= current_user.balance
        end

        def bid_taken?
            params[:bid].to_i == @auction.highest_bid || params[:bid].to_i == 0
        end

        def username_exists?(username)
            User.find_by(username: username)
        end
    end
end