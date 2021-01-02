class AddCustomerToRequests < ActiveRecord::Migration[6.0]
  def change
    add_reference :requests, :customer, null: false, foreign_key: true
  end
end
