class CreateLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :levels do |t|
      t.string :assets, array: true, null: false
      t.integer :position, null: false
      t.timestamps
      t.index :position, unique: true
    end
  end
end
