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
      p buildings_resource
      p players_resource
      return false if !players_resource || players_resource.quantity < buildings_resource.quantity
    }
    true
  end

  def build
    return false unless self.buildable?
    return false unless self.valid?
    self.buildings_resources.each { |buildings_resource|
      players_resource = PlayersResource.find_by(player: self.player, resource: buildings_resource.resource)
      players_resource.update(quantity: players_resource.quantity - buildings_resource.quantity)
    }
    self.save
    true
  end

  def upgrade(new_building)
    old_building = self.building
    self.building = new_building
    if !self.buildable? || !self.valid?
      self.building = old_building
      return false
    else
      self.build
    end
  end
end
