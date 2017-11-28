class Game < ActiveRecord::Base
    has_many :properties
    has_many :auctions
    has_many :users
    has_many :payments
end