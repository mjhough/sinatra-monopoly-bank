class RemovePropertyNameFromAuctions < ActiveRecord::Migration[5.1]
  def change
    remove_column :auctions, :property_name
  end
end
