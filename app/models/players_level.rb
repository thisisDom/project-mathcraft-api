class PlayersLevel < ApplicationRecord
  belongs_to :player
  belongs_to :level

  validates :time_started, :time_completed, { presence: true }

  def time
    self.time_completed - self.time_started
  end

  def add_resources
    levels_resources = LevelsResources.find_by(level_id: self.level_id)

    return false if levels_resources.lenght == 0

    level_resources.each { |level_resource|
      player_resource = PlayersResource.where(player_id: self.player_id, resource_id: level_resource.resource_id).first_or_create

      if level.time_limit
        resource_gain = level_resource.rate * (level_resource.level.time_limit - self.time)

        if resource_gain > level_resource.max_quantity
          resource_gain = level_resource.max_quantity
        elsif resource_gain < level_resource.min_quantity
          resource_gain = level_resource.min_quantity
        end
      else
        resource_gain = level_resource.max_quantity
      end
      
      new_resource = player_resource.quantity + resource_gain
      player_resource.update(quantity: new_resource)
    }
    true
  end

end
