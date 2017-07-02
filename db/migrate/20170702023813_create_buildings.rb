class CreateBuildings < ActiveRecord::Migration[5.1]
  def change
    create_table :buildings do |t|
      t.string :asset_link, null: false
      t.integer :width, null: false, default: 1
      t.integer :height, null: false, default: 1
      t.string :building_class, null: false
      t.integer :building_level, null: false, default: 1
      t.timestamps
      t.index :asset_link, unique: false;
    end
  end
end
