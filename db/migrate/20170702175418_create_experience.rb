class CreateExperience < ActiveRecord::Migration[5.1]
  def change
    create_table :experiences do |t|
      t.integer :level, null: false;
      t.integer :experience_needed, null: false;
      t.timestamps
      t.index :level, unique: true
      t.index :experience_needed, unique: true
    end
  end
end
