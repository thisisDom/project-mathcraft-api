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
      render json: { errors: 'Invalid Level Or Player' }, status: 404
    end
  end

  def complete
    players_level = PlayersLevel.find_by(id: players_level_params[:players_level_id])
    if players_level
      if players_level.player_id == players_level_params[:player_id].to_i
        players_level.update({time_completed: Time.current, correct_answers: players_level_params[:correct_answers]})
        players_level.add_resources
        players_level.player.level_up(players_level.level.experience)
        render json: { player: players_level.player.as_json(methods: [:level, :buildings, :resources]) }, status: 202
      else
        render json: { errors: 'Not Authorized' }, status: 402
      end
    else
      render json: { errors: 'Level Attempt Not Found' }, status: 404
    end
  end

  private

  def players_level_params
    params.require(:data).permit(:level_id, :players_level_id, :player_id, :correct_answers)
  end

end
