class ChangeIntegerLimitInPaymentsPayerAccount < ActiveRecord::Migration[5.1]
  def change
    change_column :payments, :payer_account, :integer, limit: 5
  end
end
