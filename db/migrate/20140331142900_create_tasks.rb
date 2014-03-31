class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :tasktype
      t.date :start_date
      t.date :end_date
      t.integer :days_on_hold
      t.text :reason_on_hold

      t.timestamps
    end
  end
end
