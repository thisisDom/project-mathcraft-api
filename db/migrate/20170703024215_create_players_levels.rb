class CreatePlayersLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :players_levels do |t|
      t.references :player
      t.references :level
      t.datetime :time_started
      t.datetime :time_completed
      t.timestamps
    end
  end
end
