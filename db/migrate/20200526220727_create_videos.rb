class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :overview
      t.string :release_date
      t.integer :total_inventory
      t.integer :available_inventory

      t.timestamps
    end
  end
end
