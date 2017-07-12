class PlayersLevelsController < ApplicationController

  def start
    level = Level.find_by(id: players_level_params[:level_id])
    player = Player.find_by(id: players_level_params[:player_id])
    if level && player
      players_level = PlayersLevel.new({ level: level, player: player, time_started: Time.current })
      if players_level.save
        render json: { player_level: players_level.as_json }, status: 201
      else
        render json: { errors: players_level.errors.full_messages }, status: 500
      end
    else
      render json: { errors: 'Invalid Level or Player' }, status: 404
    end
  end

  def complete
    players_level = PlayersLevel.find_by(id: players_level_params[:player_id])
    if players_level
      players_level.update(time_completed: Time.current.to_i)
      players_level.add_resources
      players_level.player.level_up(players_level.level.experience)

      render json: { player: player.as_json(methods: [:buildings, :resources, :level]) }
    else
      render json: { errors: players_level.errors.full_messages }
    end
  end

  private

  def players_level_params
    params.require(:data).permit(:level_id, :player_id)
  end

end
