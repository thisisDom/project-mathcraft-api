class PlayersController < ApplicationController
  
  def create
    player = Player.new()
    player.from_json(player_params)
    if player.save
      player.login
      render json: { player: player }
    else
      render json: { errors: player.errors.full_messages }
    end
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
