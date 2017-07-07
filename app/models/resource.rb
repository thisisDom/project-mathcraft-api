class Resource < ApplicationRecord
  has_many :buildingsresources
  has_many :buildings, { through: :buildingsresources }

  validates :name, { presence: true,
                     uniqueness: { case_sensitive: false }
                   }
end
