class Resource < ApplicationRecord
  has_many :buildings_resources
  has_many :buildings, { through: :buildings_resources }

  validates :name, { presence: true,
                     uniqueness: { case_sensitive: false }
                   }
end
