class ChangeColumnDefaultValue < ActiveRecord::Migration[6.0]
  def change
    change_column :videos, :available_inventory, :integer, default: nil
  end
end
