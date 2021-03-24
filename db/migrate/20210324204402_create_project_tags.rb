class CreateProjectTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :project_tags_count, null: false, default: 0

      t.timestamps
    end
  end
  
end
