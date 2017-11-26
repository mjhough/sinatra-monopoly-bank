class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.integer :price
      t.integer :rent
      t.integer :user_id
      t.integer :auction_id
    end
  end
end
