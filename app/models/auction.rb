class Auction < ActiveRecord::Base
    belongs_to :property
    belongs_to :payment
end