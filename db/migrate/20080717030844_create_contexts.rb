class CreateContexts < ActiveRecord::Migration
  def self.up
    create_table :contexts do |t|
      t.string :name
      t.text :note
      t.integer :user_id
      t.timestamps
    end
    add_index :contexts, :user_id
  end

  def self.down
    drop_table :contexts
  end
end
