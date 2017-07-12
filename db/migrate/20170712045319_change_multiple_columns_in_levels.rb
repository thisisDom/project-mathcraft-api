class ChangeMultipleColumnsInLevels < ActiveRecord::Migration[5.1]
  def change
    add_column(:levels, :title, :string)
    add_column(:levels, :level_type, :string)
    add_column(:levels, :level_requirement, :integer)
  end
end
