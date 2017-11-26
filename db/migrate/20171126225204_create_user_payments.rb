class CreateUserPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :user_payments do |t|
      t.integer :user_id
      t.integer :payment_id
    end
  end
end