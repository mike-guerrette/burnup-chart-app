class AddProjectReleaseDate < ActiveRecord::Migration
    def self.up
      add_column :projects, :release_date, :date
      add_column :projects, :created_date, :date
    end
end
