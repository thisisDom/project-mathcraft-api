class ChangeColumnAssetsInLevels < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    remove_column(:levels, :assets)
    add_column(:levels, :assets, :hstore, default: { "phaser-background" => "", "calculator-background" => "", "minions" => [], "boss" => ""})
  end
end
