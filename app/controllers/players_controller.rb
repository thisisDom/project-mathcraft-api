class PlayersController < ApplicationController

  def create
    player = Player.new()
    player.from_json(player_params)
    if player.save
      player.login
      render json: { player: player.as_json }
    else
      render json: { errors: player.errors.full_messages }
    end
  end

  def show
    player = Player.find_by(id: params[:id])
    if player
      render json: { player: player.as_json(methods: [:buildings, :resources, :level]) }
    else
      render json: { errors: player.errors.full_messages }
    end
  end

  def delete
    Player.find_by(id: params[:id]).destroy
  end

  private

  def player_params
    params.require(:data).require(:player).permit(:username,
                                                  :email_address,
                                                  :password,
                                                  :avatar_asset_link
                                                 )
  end

end
