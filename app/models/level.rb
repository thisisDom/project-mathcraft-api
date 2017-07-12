class Level < ApplicationRecord
  serialize :assets, ActiveRecord::Coders::NestedHstore

  has_many :levels_resources
  has_many :resources, { through: :levels_resources }

  validates :assets, { presence: true }
  validates :position, { presence: true,
                         numericality: { only_integer: true,
                                           greater_than_or_equal_to: 1
                                         },
                         uniqueness: true
                       }
  validates :experience, { presence: true,
                           numericality: { only_integer: true,
                                          greater_than_or_equal_to: 0
                                         }
                         }


  def generated_questions

  end

  private

  def set_default_values
    self.assets ||= nil
  end

end
