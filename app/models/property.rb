class Property < ActiveRecord::Base
    belongs_to :user
    belongs_to :auction
    has_many :payments
    belongs_to :game
end