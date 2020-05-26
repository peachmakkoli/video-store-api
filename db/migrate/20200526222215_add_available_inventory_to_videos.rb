class AddAvailableInventoryToVideos < ActiveRecord::Migration[6.0]
  def change
    remove_column :videos, :available_inventory
    add_column :videos, :available_inventory, :integer, default: 0
    add_index :videos, :available_inventory
  end
end
