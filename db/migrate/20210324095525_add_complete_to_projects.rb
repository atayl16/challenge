class AddCompleteToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :enrollments, :complete, :boolean, default: false  
  end
end
