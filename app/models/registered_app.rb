class RegisteredApp < ApplicationRecord
  has_secure_password

  validates :email_address, { presence: true,
                              uniqueness: { case_sensitive: false }
                            }
end
