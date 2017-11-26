class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :payee_account
      t.integer :payer_account
      t.integer :amount
      t.string :description
      t.timestamps
      t.integer :property_id
      t.integer :auction_id
    end
  end
end
