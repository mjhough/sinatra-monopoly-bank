class AddTimestampsToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :created_at, :datetime
    add_column :properties, :updated_at, :datetime
  end
end
