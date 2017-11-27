module Helpers
    module InstanceMethods
        def logged_in?
            !!session[:user_id]
        end

        def game_exists?
            !!session[:game_value]
        end

        def current_user
            User.find_by_id(session[:user_id])
        end
    end
end