class AddAuctionIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :auction_id, :integer
  end
end
