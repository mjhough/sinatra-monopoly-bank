class AddCompleteToAuctions < ActiveRecord::Migration[5.1]
  def change
    add_column :auctions, :complete, :boolean, :default => false
  end
end
