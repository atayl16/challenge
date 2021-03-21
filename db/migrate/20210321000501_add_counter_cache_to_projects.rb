class AddCounterCacheToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :enrollments_count, :integer, null: false, default: 0
  end
end
