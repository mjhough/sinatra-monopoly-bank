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
            end
        end

        def auction_over?(auction_id)
            auction = Auction.find(params[:id])
            waiting_on.empty?
        end

        def waiting_on
            users_in_auction = User.where(auction: @auction)
            users_in_game = User.where(game: current_game)
            users_in_game - users_in_auction
        end

        def in_progress_auction
            Auction.where(in_progress: true).first
        end
    end
end