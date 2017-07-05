class JsonWebToken
  class << self
    def encode(payload, expiration = 24.hours.from_now)
      payload[:exp] = expiration.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndefferentAccess.new(body)
    rescue
      nil
    end
  end
end
