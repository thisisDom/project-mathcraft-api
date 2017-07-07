class ChangeIndexInBuildings < ActiveRecord::Migration[5.1]
  def change
    remove_index(:buildings, :asset_link)
    add_index(:buildings, :asset_link, unique: true)
  end
end
