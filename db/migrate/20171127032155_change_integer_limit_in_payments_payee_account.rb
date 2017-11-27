class ChangeIntegerLimitInPaymentsPayeeAccount < ActiveRecord::Migration[5.1]
  def change
    change_column :payments, :payee_account, :integer, limit: 5
  end
end
