class CreateProjectFiles < ActiveRecord::Migration
  def change
    create_table :project_files do |t|
      t.string :name
      t.string :hash
      t.integer :project_id

      t.timestamps
    end
  end
end
