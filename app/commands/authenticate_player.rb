class AuthenticatePlayer

  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: player.id) if player
  end

  private

  attr_accessor :email, :password

  def player
    player = Player.find_by(email: email)
    return player if player && player.authenticate(password)
    errors.add(:user_authentication, 'invalid email or password')
    nil
  end

end
