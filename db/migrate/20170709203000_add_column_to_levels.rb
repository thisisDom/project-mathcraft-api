class AddColumnToLevels < ActiveRecord::Migration[5.1]
  def change
    add_column(:levels, :experience, :integer, default: 0)
  end
end
