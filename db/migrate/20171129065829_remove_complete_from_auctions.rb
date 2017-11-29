class RemoveCompleteFromAuctions < ActiveRecord::Migration[5.1]
  def change
    remove_column :auctions, :complete
  end
end
