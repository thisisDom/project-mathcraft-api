class PlayersLevelsController < ApplicationController

  def create
    level = Level.find_by(id: players_level_params[:level_id])
    player = Player.find_by(id: params[:player_id])
    if level && player
      PlayersLevel.create({level: level, player: player, time_started: Time.current.to_i})
      render json: { level: level.as_json[methods: :generated_questions] }, status: 201
    else
      render json: { errors: 'Invalid Level or Player' }, status: 404
    end
  end

  def update
    players_level = PlayersLevel.find_by(id: params[:player_id])
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
    params.require(:data).premit(:level_id)
  end

end
