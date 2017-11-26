class Payment < ActiveRecord::Base
    has_many :user_payments
    has_many :users, through: :user_payments
    belongs_to :property
    belongs_to :auction
end