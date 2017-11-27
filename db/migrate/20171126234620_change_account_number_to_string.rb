class ChangeAccountNumberToString < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :account_number, :string
  end
end
