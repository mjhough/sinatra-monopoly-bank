class CreateBidders < ActiveRecord::Migration[5.1]
  def change
    create_table :bidders do |t|
      t.integer :auction_id
      t.integer :user_id
      t.integer :bid
    end
  end
end
