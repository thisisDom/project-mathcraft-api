class AuthorizationController < ApplicationController
  
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticatePlayer.call(params[:email_address], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

end
