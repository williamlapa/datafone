class Customer < ApplicationRecord
  has_many :requests, dependent: :destroy
  belongs_to :user
  validates_presence_of :name, :address, :value, :customer_since
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
