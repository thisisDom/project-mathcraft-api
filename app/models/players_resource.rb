class PlayersResource < ApplicationRecord
  belongs_to :resource
  belongs_to :player

  validates :quantity, { presence: true, numericality: { greater_than_or_equal_to: 0 }}
end
