# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080726035340) do

  create_table "contexts", :force => true do |t|
    t.string   "name"
    t.text     "note"
    t.integer  "user_id",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  add_index "contexts", ["user_id"], :name => "index_contexts_on_user_id"
  add_index "contexts", ["permalink"], :name => "index_contexts_on_permalink"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "note"
    t.integer  "user_id",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"
  add_index "projects", ["permalink"], :name => "index_projects_on_permalink"

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.integer  "project_id", :limit => 11
    t.integer  "context_id", :limit => 11
    t.integer  "user_id",    :limit => 11
    t.datetime "due"
    t.datetime "completed"
    t.text     "note"
    t.integer  "time_spent", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"
  add_index "tasks", ["context_id"], :name => "index_tasks_on_context_id"
  add_index "tasks", ["user_id"], :name => "index_tasks_on_user_id"
  add_index "tasks", ["permalink"], :name => "index_tasks_on_permalink"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
