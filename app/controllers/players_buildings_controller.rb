class PlayersBuildingsController
  before_action :check_ownership, except: :index
  before_action :check_existence, only: [:upgrate, :move, :delete]

  def index
    players_buildings = Playersbuildings.find_by(player_id: params[:player_id])
    render json: { buildings: players_buildings.as_json}
  end

  def create
    players_building = Playersbuildings.new(player: params[:player_id], building_id: building_params[:building_id], position: building_params[:position])
    if players_building.build
      if players_building.save
        render json: { player: player.as_json(methods: [:buildings, :resources, :level]) }
      else
        render json: { errors: players_building.errors.full_messages }
      end
    else
      render json: { errors: 'Not Enough Resources' }
    end
  end

  def upgrade
    players_building = Playersbuildings.find_by(id: params[:id])
    players_building.building = Building.find_by(id: building_params[:building_id])
    if players_building.build
      if players_building.save
        render json: { player: Player.find_by(id: params[:player_id]).as_json(methods: [:buildings, :resources, :level]) }
      else
        render json { errors: players_building.errors.full_messages }
      end
    else
      render json { errors: 'Not Enough Resources' }
    end
  end

  def move
    players_building = Playersbuildings.find_by(id: params[:id])
    if players_building.update(position: building_params[:position])
      render json: { player: Player.find_by(id: params[:player_id]).as_json(methods: [:buildings, :resources, :level]) }
    else
      render json: { errors: players_building.errors.full_messages }
    end
  end

  def destroy
    Playersbuildings.find_by(id: params[:id]).destroy
    render json: { player: Player.find_by(id: params[:player_id]).as_json(methods: [:buildings, :resources, :level]) }
  end

  private

  def building_params
    params.require(:data).require(:building).permit(:building_id, :position)
  end

  def check_ownership
    if Playersbuildings.find_by(id: params[:id])g.player_id != params[:player_id]
      render json: { errors: 'Not Authorized' }
    end
  end

  def check_existence
    player = Player.find_by(id: params[:player_id])
    building = Building.find_by(id: building_params[:building_id])
    if !player || !building
      render json: { errors: { player: player.errors.full_messages, building: building.errors.full_messages } }
    end

  end


end
