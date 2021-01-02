class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :motivation
      t.string :status
      t.string :itens
      t.string :employee_name
      t.string :employee_mobile
      t.string :description
      t.string :role
      t.datetime :initial_date
      t.datetime :final_date

      t.timestamps
    end
  end
end
