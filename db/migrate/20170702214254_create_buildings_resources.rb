class CreateBuildingsResources < ActiveRecord::Migration[5.1]
  def change
    create_table :buildings_resources do |t|
      t.references :resource
      t.references :building
      t.integer :quantity  
      t.timestamps
    end
  end
end
