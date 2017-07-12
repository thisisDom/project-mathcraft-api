class ChangeLocationColumnInPlayersBuildings < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    remove_column(:players_buildings, :location)
    add_column(:players_buildings, :location, :hstore, default: { "tile" => "", "offset-x" => "", "offset-y" => ""})
  end
end
