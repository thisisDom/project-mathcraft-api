class PlayersBuildingsController < ApplicationController
  before_action :check_ownership, except: [:index, :create]
  before_action :check_existence, only: [:upgrade, :move, :delete]

  def index
    if Player.find_by(id: players_building_params[:player_id])
      players_buildings = PlayersBuilding.where(player_id: players_building_params[:player_id])
      render json: { buildings: players_buildings.as_json }, status: 200
    end
  end

  def create
    players_building = PlayersBuilding.new(player_id: players_building_params[:player_id], building_id: players_building_params[:building_id], location: players_building_params[:location])
    if players_building.build
      if players_building.save
        player = Player.find_by(id: players_building.player.id)
        render json: { player: player.as_json(methods: [:level, :buildings, :resources]) }
      else
        render json: { errors: players_building.errors.full_messages }
      end
    else
      render json: { errors: 'Not Enough Resources' }
    end
  end

  def upgrade
    players_building = PlayersBuilding.find_by(id: players_building_params[:players_building_id])
    players_building.building = Building.find_by(id: players_building_params[:building_id])
    if players_building.build
      if players_building.save
        render json: { player: Player.find_by(id: players_building_params[:player_id]).as_json(methods: [:buildings, :resources, :level]) }
      else
        render json: { errors: players_building.errors.full_messages }
      end
    else
      render json: { errors: 'Not Enough Resources' }
    end
  end

  def move
    players_building = PlayersBuildings.find_by(id: players_building_params[:players_building_id])
    if players_building.update(location: players_building_params[:location])
      render json: { player: Player.find_by(id: players_building_params[:player_id]).as_json(methods: [:buildings, :resources, :level]) }
    else
      render json: { errors: players_building.errors.full_messages }
    end
  end

  def destroy
    PlayersBuilding.find_by(id: players_building_params[:players_building_id]).destroy
    render json: {player: Player.find_by(id: players_building_params[:player_id]).as_json(methods: [:buildings, :resources, :level]) }
  end

  private

  def players_building_params
    params.require(:data).permit(:player_id, :building_id, :location, :players_building_id)
  end

  def check_ownership
    id = players_building_params[:player_id]
    if PlayersBuilding.find_by(id: players_building_params[:players_building_id]).player_id != id.to_i
      render json: { errors: 'Not Authorized' }
    end
  end

  def check_existence
    player = Player.find_by(id: players_building_params[:player_id])
    building = Building.find_by(id: players_building_params[:building_id])
    if !player || !building
      render json: { errors: 'Invalid Player or Building' }
    end
  end


end
