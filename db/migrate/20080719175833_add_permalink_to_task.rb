class AddPermalinkToTask < ActiveRecord::Migration
  def self.up
    add_column :tasks, :permalink, :string
  end

  def self.down
    remove_column :tasks, :permalink
  end
end
