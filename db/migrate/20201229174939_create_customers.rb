class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.float :value
      t.datetime :customer_since
      t.datetime :customer_final

      t.timestamps
    end
  end
end
