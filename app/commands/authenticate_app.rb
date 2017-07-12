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
    user = RegisteredApp.find_by(email_address: email)
    return user if user && user.authenticate(password)
    errors.add(:user_authentication, 'Invalid email or Password')
    nil
  end

end
