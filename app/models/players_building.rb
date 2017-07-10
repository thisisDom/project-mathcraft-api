class PlayersBuilding < ApplicationRecord
  belongs_to :player
  belongs_to :building

  validates :location, { presence: true, uniqueness: { scope: :player_id } }

  def buildings_resources
    BuildingsResource.where(building_id: self.building_id)
  end

  def buildable?
    self.buildings_resources.each { |buildings_resource|
      players_resource = PlayersResource.find_by(player: self.player, resource: buildings_resource.resource)
      return false if !players_resource || players_resource.quantity < buildings_resource.quantity
    }
    true
  end

  def build
    return false unless self.buildable?

    self.buildings_resources.each { |buildings_resource|
      players_resource = PlayersResource.find_by(player: self.player, resource: buildings_resource.resource)
      return false if !players_resource || players_resource.quantity < buildings_resource.quantity
      players_resource.update(quantity: players_resource.quantity - buildings_resource.quantity)
    }
    true
  end

end
