class Auction < ActiveRecord::Base
    belongs_to :property
    belongs_to :payment
    belongs_to :game
end