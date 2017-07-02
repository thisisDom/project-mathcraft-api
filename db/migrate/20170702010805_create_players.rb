class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :username, null: false
      t.string :email_address, null: false
      t.string :password_digest, null: false
      t.string :avatar_asset_link
      t.integer :experience, null: false, default: 0
      t.timestamps
      t.index :username, unique: true
      t.index :email_address, unique: true
    end
  end
end
