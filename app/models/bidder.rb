class Bidder < ActiveRecord::Base
    belongs_to :auction
    belongs_to :user
end