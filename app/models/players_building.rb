class PlayersBuilding < ApplicationRecord
  belongs_to :player
  belongs_to :building

  validates :location, { presence: true }
end
