class AddZoneToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :zone, :string
  end
end
