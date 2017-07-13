class BuildingsController < ApplicationController

  def index
    player = Player.find_by(id: params[:player_id])
    buildings = Building.all.select { |building|
                  PlayersBuilding.new(player: player, building: building).buildable?
                }.map { |building|
                    new_building = building.serializable_hash
                    new_building[:resources] = building.resources
                    new_building
                  }
    render json: { buildings: buildings.as_json }
  end

end
