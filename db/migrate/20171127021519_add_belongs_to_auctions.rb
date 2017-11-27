class AddBelongsToAuctions < ActiveRecord::Migration[5.1]
  def change
    add_column :auctions, :property_id, :integer
    add_column :auctions, :payment_id, :integer
  end
end
