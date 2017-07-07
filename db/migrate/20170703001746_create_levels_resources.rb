class CreateLevelsResources < ActiveRecord::Migration[5.1]
  def change
    create_table :levels_resources do |t|
      t.integer :rate
      t.integer :max_resources
      t.integer :min_resources
      t.references :resource
      t.references :level
      t.timestamps
    end
  end
end
