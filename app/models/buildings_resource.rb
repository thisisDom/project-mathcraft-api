class BuildingsResource < ApplicationRecord
  belongs_to :resource
  belongs_to :building

  validates :quantity, { presence: true, numericality: { greater_than_or_equal_to: 0 }}
end
