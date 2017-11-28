class AddGameIdToAuctions < ActiveRecord::Migration[5.1]
  def change
    add_column :auctions, :game_id, :integer
  end
end
