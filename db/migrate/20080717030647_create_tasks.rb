class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.integer :project_id
      t.integer :context_id
      t.integer :user_id
      t.datetime :due
      t.datetime :completed
      t.text :note
      t.integer :time_spent
      t.timestamps
    end
    add_index :tasks, :project_id
    add_index :tasks, :context_id
     add_index :tasks, :user_id
  end

  def self.down
    drop_table :tasks
  end
end
