class PlayersLevel < ApplicationRecord
  belongs_to :player
  belongs_to :level

  validates :time_started, :time_completed, { presence: true }
end
