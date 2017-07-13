class PlayersController < ApplicationController
  # TODO delete index route
  def create
    player = Player.new(player_params)
    if player.save
      player.login
      render json: { player: player.as_json }, status: 201
    else
      render json: { errors: player.errors.full_messages }, status: 406
    end
  end

  def show
    player = Player.find_by(id: params[:id])
    if player
      render json: { player: player.as_json(methods: [:level, :buildings, :resources]) }
    else
      render json: { errors: 'Player Not Found' }, status: 404
    end
  end

  def destroy
    Player.find_by(id: params[:id]).destroy
  end

  private

  def player_params
    params.require(:player).permit(:username,
                                   :email_address,
                                   :password,
                                   :avatar_asset_link
                                 )
  end

end
