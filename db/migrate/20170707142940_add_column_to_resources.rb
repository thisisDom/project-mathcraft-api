class AddColumnToResources < ActiveRecord::Migration[5.1]
  def change
    add_column(:resources, :asset_link, :string, null: false)
  end
end
