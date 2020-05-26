class AddVideosCheckedOutCountToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :videos_checked_out_count, :integer, default: 0
    add_index :customers, :videos_checked_out_count
  end
end
