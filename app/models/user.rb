class User < ActiveRecord::Base
    has_many :user_payments
    has_many :payments, through: :user_payments
    has_many :properties
    belongs_to :game
    belongs_to :bidder
    belongs_to :auction
    has_secure_password
end