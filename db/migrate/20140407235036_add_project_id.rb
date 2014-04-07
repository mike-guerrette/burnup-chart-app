class AddProjectId < ActiveRecord::Migration
  def self.up
    add_column :tasks, :project_id, :integer
  end
end
