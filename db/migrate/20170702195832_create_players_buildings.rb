class CreatePlayersBuildings < ActiveRecord::Migration[5.1]
  def change
    create_table :players_buildings do |t|
      t.references :player
      t.references :building
      t.string :location, array: true
      t.timestamps
    end
  end
end
