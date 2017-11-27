class ChangePayerAccountToString < ActiveRecord::Migration[5.1]
  def change
    change_column :payments, :payer_account, :string
  end
end
