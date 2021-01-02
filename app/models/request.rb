class Request < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  validates_presence_of :motivation, :status, :itens, :employee_name, :employee_mobile, :role, :initial_date
end
