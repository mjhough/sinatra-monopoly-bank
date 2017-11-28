class AddNotNullToProperties < ActiveRecord::Migration[5.1]
  def change
    change_column :properties, :created_at, :datetime, :null => false
    change_column :properties, :updated_at, :datetime, :null => false
  end
end
