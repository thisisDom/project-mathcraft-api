class PlayersLevel < ApplicationRecord
  belongs_to :player
  belongs_to :level

  validates :time_started, { presence: true }

  def time
    self.time_completed.to_i - self.time_started.to_i
  end

  def add_resources

    return false if self.level.levels_resources.length == 0

    self.level.levels_resources.each { |levels_resource|
      player_resource = PlayersResource.where(player: self.player, resource: levels_resource.resource).first_or_create
      if level.time_limit
        resource_gain = levels_resource.rate * self.correct_answers

        if resource_gain > levels_resource.max_quantity
          resource_gain = levels_resource.max_quantity
        elsif resource_gain < levels_resource.min_quantity
          resource_gain = levels_resource.min_quantity
        end
      else
        resource_gain = levels_resource.max_quantity
      end

      new_resource = player_resource.quantity + resource_gain
      player_resource.update(quantity: new_resource)
    }
    true
  end


end
