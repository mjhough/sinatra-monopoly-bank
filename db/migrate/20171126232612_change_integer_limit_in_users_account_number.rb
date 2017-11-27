class ChangeIntegerLimitInUsersAccountNumber < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :account_number, :integer, limit: 5
  end
end
