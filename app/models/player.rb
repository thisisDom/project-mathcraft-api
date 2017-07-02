class Player < ApplicationRecord
  has_secure_password

  validates :email_address, :username, { presence: true, uniqueness: { case_sensetive: false } }
  validates :experience, { presence: true,
                           numericality: { only_integer: true,
                                           greater_than_or_equal_to: 0
                                         }
                         }
  validates :avatar_asset_link, { presence: true }
  
end
