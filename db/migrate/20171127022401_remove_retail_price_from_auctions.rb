class RemoveRetailPriceFromAuctions < ActiveRecord::Migration[5.1]
  def change
    remove_column :auctions, :retail_price
  end
end
