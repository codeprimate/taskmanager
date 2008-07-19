class AddPermalinkToContext < ActiveRecord::Migration
  def self.up
    add_column :contexts, :permalink, :string
  end

  def self.down
    remove_column :contexts, :permalink
  end
end
