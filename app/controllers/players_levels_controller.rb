class PlayersLevelsController < ApplicationController

  def start
    level = Level.find_by(id: params[:level_id])
    player = Player.find_by(id: params[:player_id])
    if level && player
      PlayersLevel.create({level: level, player: player, time_started: Time.current.to_i})
      render json: { level: level.as_json[except: :cards, methods: :generated_questions]}
    else
      render json: { errors: { level: level.errors.full_messages, player: player.errors.full_messages }
    end
  end

  def complete
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

  def player_params
    params.require(:data).premit(:level_id)
  end

end
