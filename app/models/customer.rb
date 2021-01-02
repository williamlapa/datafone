class Customer < ApplicationRecord
  has_many :requests, dependent: :destroy
  belongs_to :user
  has_one_attached :photo
  validates_presence_of :name, :address, :value, :customer_since, :zone
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model

  pg_search_scope :search_by_name_zone_and_address,
                  against: %i[name zone address],
                  using: {
                    tsearch: { prefix: true }
                  }
end
