class CreateAuctions < ActiveRecord::Migration[5.1]
  def change
    create_table :auctions do |t|
      t.string :property_name
      t.integer :time_limit
      t.integer :retail_price
    end
  end
end
