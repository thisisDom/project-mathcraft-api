class ChangeWidthAndHeightInBuildings < ActiveRecord::Migration[5.1]
  def change
    remove_column(:buildings, :height)
    remove_column(:buildings, :width)
    add_column(:buildings, :offsetX, :integer)
    add_column(:buildings, :offsetY, :integer)
  end
end
