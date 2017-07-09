class PlayersLevelsController < ApplicationController

  def start
    level = Level.find_by(id: params[:id])
    if level
      PlayersLevel.create({level: level, player: Player.find_by(id: session[:id]), time_started: Time.current.to_i})
      render json: { level: level.as_json[except: :cards, methods: :generated_questions]}
    else
      render json: { errors: level.errors.full_messages }
    end
  end

  def complete
    players_level = PlayersLevel.find_by(id: params[:id])
    if players_level
      players_level.update(time_completed: Time.current.to_i)
      players_level.add_resources
    else

    end
  end

end
