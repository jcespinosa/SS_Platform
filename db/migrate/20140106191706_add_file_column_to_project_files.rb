class AddFileColumnToProjectFiles < ActiveRecord::Migration
  def change
    add_attachment :project_files, :attachment
  end
end
