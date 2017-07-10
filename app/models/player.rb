class Player < ApplicationRecord
  has_many :players_resources

  has_many :level_attempts, { class_name: 'PlayersLevel' }

  has_many :players_buildings

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

  def buildings
    return [] if self.players_buildings.length == 0
    self.players_buildings.map { |players_building|
       players_building.serializable_hash.merge(players_building.building.serializable_hash) { |key, oldval, newval|
         oldval
       }
    }
  end

  def resources
    return [] if self.players_resources.length == 0
    self.players_resources.map { |players_resource|
       players_resource.serializable_hash.merge(players_resource.resource.serializable_hash) { |key, oldval, newval|
         oldval
       }
    }
  end

  def level
    Experience.first.where("experience_needed >= ? ASC", self.experience).pluck(:level)
  end

  def level_up(level_experience)
    new_experience = self.experience + level_experience
    self.update(experience: new_experience)
  end

end
