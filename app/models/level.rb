class Level < ApplicationRecord

  validates :assets, { presence: true }
  validates :position, { presence: true,
                         numericality: { only_integer: true,
                                           greater_than_or_equal_to: 1
                                         },
                         uniqueness: true
                       }
end
