class Player < ApplicationRecord
  has_many :playersresource
  has_many :resources, { through: :playersresource }

  has_many :level_attempts, { class_name: 'PlayersLevel' }
  has_many :levels, { through: :level_attempts }

  has_many :playersbuildings
  has_many :buildings, { through: :playersbuildings }

  has_secure_password

  validates :email_address, :username, { presence: true,
                                         uniqueness: { case_sensetive: false }
                                       }
  validates :experience, { presence: true,
                           numericality: { only_integer: true,
                                           greater_than_or_equal_to: 0
                                         }
                         }
  validates :avatar_asset_link, { presence: true }


  def self.authentication(credentials)
    player = Player.find_by(email_address: credentials[:email_address])
    player && player.authenticate(credentials[:password]) ? player : nil
  end

  def login
      self.update_attributes({ login_status: true })
  end

  def logout
    self.update_attributes({ login_status: false })
  end

end
