class AddGameIdToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :game_id, :integer
  end
end
