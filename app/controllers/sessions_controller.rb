class SessionsController < ApplicationController
  def login
    player = Player.authentication(params[:user])
    if player
      player.login
      render json: { player: player }
    else
      render json: { errors: 'Invalid Email or Password' }
    end
  end

  def logout
    player = Player.find_by(id: params[:user][:id])
    if player
      player.logout
    end
    render json: { data: true }
  end
end
