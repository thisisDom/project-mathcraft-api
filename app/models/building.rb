class Building < ApplicationRecord
  has_many :players_buildings
  has_many :players, { through: :players_buildings }

  has_many :buildings_resources

  validates :asset_link, { presence: true,
                           uniqueness: { case_sensetive: false }
                         }
  validates :building_class, { presence: true }
  validates :building_level, { presence: true,
                                                numericality: { only_integer: true,
                                                               greater_than_or_equal_to: 1
                                                             }
                                               }
   validates :offsetY, :offsetX, { presence: true, numericality: true }

   def resources
     return {} if self.buildings_resources.length == 0
     self.buildings_resources.map { |buildings_resource|
        buildings_resource.serializable_hash.merge(buildings_resource.resource.serializable_hash) { |key, oldval, newval|
          oldval
        }
     }
   end
end
