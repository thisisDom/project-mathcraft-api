class Experience < ApplicationRecord
  validates :level, :experience_needed, { presence: true,
                                             uniqueness: true,
                                             numericality: { greater_than_or_equal_to: 0 }
                                           }

  def experience_needed
    self.experience_needed = self.level ** 3
  end
end
