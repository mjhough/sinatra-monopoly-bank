class AddBidderIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bidder_id, :integer
  end
end
