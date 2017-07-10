class CreatePlayersResources < ActiveRecord::Migration[5.1]
  def change
    create_table :players_resources do |t|
      t.references :resource
      t.references :player
      t.integer :quantity
      t.timestamps
    end
  end
end
