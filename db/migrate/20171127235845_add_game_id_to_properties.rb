class AddGameIdToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :game_id, :integer
  end
end
