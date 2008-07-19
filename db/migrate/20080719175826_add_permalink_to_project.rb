class AddPermalinkToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :permalink, :string
  end

  def self.down
    remove_column :projects, :permalink
  end
end
