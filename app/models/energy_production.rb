class EnergyProduction < ApplicationRecord
  belong_to :house
  validates :House, presence: true
end
