class Building < ApplicationRecord
  has_many :players_buildings
  has_many :players, { through: :players_buildings }

  has_many :buildings_resources
  has_many :resources, { through: :buildings_resources }

  validates :asset_link, { presence: true,
                           uniqueness: { case_sensetive: false }
                         }
  validates :building_class, { presence: true }
  validates :height, :width, :building_level, { presence: true,
                                                numericality: { only_integer: true,
                                                               greater_than_or_equal_to: 1
                                                             }
                                               }


end
