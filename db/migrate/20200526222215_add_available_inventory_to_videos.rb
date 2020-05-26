class AddAvailableInventoryToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :available_inventory, :integer, default: 0
    add_index :videos, :available_inventory
  end
end
