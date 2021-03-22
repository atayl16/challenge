class RenameDescriptionToRequirements < ActiveRecord::Migration[6.1]
  def change
    rename_column :projects, :description, :requirements
  end
end
