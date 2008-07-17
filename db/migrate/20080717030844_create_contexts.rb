class CreateContexts < ActiveRecord::Migration
  def self.up
    create_table :contexts do |t|
      t.string :name
      t.text :note

      t.timestamps
    end
    Context.create(:name => "Inbox")
  end

  def self.down
    drop_table :contexts
  end
end
