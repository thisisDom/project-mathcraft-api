class PlayersResource < ApplicationRecord
  after_initialize :set_default_values

  belongs_to :resource
  belongs_to :player

  validates :quantity, { presence: true, numericality: { greater_than_or_equal_to: 0 }}

  private

  def set_default_values
    self.quantity ||= 0
  end
end
