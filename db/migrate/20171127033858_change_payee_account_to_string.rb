class ChangePayeeAccountToString < ActiveRecord::Migration[5.1]
  def change
    change_column :payments, :payee_account, :string
  end
end
