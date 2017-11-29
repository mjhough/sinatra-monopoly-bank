class AddHighestBidToAuctions < ActiveRecord::Migration[5.1]
  def change
    add_column :auctions, :highest_bid, :integer
  end
end
