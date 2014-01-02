class CreateProjectFiles < ActiveRecord::Migration
  def change
    create_table :project_files do |t|
      t.string :name
      t.string :file_hash
      t.integer :project_id
      t.text :description

      t.timestamps
    end
  end
end
