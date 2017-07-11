class AddTimeLimitColumnToLevels < ActiveRecord::Migration[5.1]
  def change
    add_column(:levels, :time_limit, :integer)
  end
end
