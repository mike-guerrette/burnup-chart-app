class CreateScopeChanges < ActiveRecord::Migration
  def change
    create_table :scope_changes do |t|
      t.integer :project_id
      t.integer :scope
      t.timestamps
    end
  end
end
