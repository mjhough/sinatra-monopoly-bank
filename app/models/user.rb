class User < ActiveRecord::Base
    has_many :user_payments
    has_many :payments, through: :user_payments
    has_many :properties
    has_secure_password
end