class ChangeDateFieldsToDateDatatype < ActiveRecord::Migration[6.0]
  def change
    change_column :videos, :release_date, :date
    change_column :rentals, :due_date, :date
  end
end
