class AddNameColumnToBuildings < ActiveRecord::Migration[5.1]
  def change
    add_column(:buildings, :name, :string)
  end
end
