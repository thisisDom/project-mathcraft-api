class CreateRegisteredApps < ActiveRecord::Migration[5.1]
  def change
    create_table :registered_apps do |t|
      t.string :email_address, null: false
      t.string :password_digest
      t.timestamps
      t.index :email_address, unique: true
    end
  end
end
