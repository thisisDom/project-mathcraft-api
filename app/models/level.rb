class Level < ApplicationRecord
  serialize :assets, ActiveRecord::Coders::NestedHstore

  has_many :levels_resources

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

  def resources
    return {} if self.levels_resources.length == 0
    self.levels_resources.map { |levels_resource|
       levels_resource.serializable_hash.merge(levels_resource.resource.serializable_hash) { |key, oldval, newval|
         oldval
       }
    }
  end

  private

  def set_default_values
    self.assets ||= nil
  end

end
