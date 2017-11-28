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

        def clear_game
            if game_exists?
                Auction.destroy_all
                Property.destroy_all
                Payment.destroy_all
                session[:game_value].clear
            else
                raise "No game found"
            end
        end
    end
end