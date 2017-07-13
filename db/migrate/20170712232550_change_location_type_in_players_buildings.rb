class ChangeLocationTypeInPlayersBuildings < ActiveRecord::Migration[5.1]
  def change
    remove_column(:players_buildings, :location)
    add_column(:players_buildings, :location, :integer)
  end
end
