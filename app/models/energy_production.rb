class EnergyProduction < ApplicationRecord
  belongs_to :house
  validates :house_id, presence: true
end
