class AuthenticateApp

  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  def user
    user = RegisteredApps.find_by(email_address: email_address)
    return user if user && user.authenticate(password)
    errors.add(:user_authentication, 'invalid email or password')
    nil
  end

end
