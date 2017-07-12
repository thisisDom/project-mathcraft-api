class AddCorrectAnswerColumnToPlayersLevels < ActiveRecord::Migration[5.1]
  def change
    add_column(:players_levels, :correct_answers, :integer)
  end
end
