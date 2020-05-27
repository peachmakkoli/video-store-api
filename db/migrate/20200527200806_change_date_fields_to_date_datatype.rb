class ChangeDateFieldsToDateDatatype < ActiveRecord::Migration[6.0]
  def change
    change_column :videos, :release_date, 'date USING CAST(release_date AS date)'
    change_column :rentals, :due_date, 'date USING CAST(due_date AS date)'
  end
end
