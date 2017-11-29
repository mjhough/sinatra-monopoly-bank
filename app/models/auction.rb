class Auction < ActiveRecord::Base
    belongs_to :property
    belongs_to :payment
    belongs_to :game
    has_many :bidders

    def start
        
    end

    def timer(method)
        time_limit = self.time_limit
        timers.after(time_limit) {method}
    end


end