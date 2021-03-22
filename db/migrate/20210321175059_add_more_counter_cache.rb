class AddMoreCounterCache < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :projects_count, :integer, null: false, default: 0
    add_column :users, :enrollments_count, :integer, null: false, default: 0
  end
end
