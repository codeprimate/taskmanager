class AddPermalinkIndexes < ActiveRecord::Migration
  def self.up
    add_index :tasks, :permalink
    add_index :projects, :permalink
    add_index :contexts, :permalink
  end

  def self.down
    remove_index :tasks, :permalink
    remove_index :projects, :permalink
    remove_index :contexts, :permalink
  end
end
