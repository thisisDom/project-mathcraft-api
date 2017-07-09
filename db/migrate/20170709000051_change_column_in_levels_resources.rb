class ChangeColumnInLevelsResources < ActiveRecord::Migration[5.1]
  def change
    rename_column(:levels_resources, :max_resources, :max_quantity)
    rename_column(:levels_resources, :min_resources, :min_quantity)
  end
end
