class CreateResources < ActiveRecord::Migration[5.1]
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.timestamps
      t.index :name, unique: true
    end
  end
end
