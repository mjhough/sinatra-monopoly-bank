class AddDefaultValueOf0ToHighestBidInAuctions < ActiveRecord::Migration[5.1]
  def change
    change_column :auctions, :highest_bid, :integer, :default => 0
  end
end
