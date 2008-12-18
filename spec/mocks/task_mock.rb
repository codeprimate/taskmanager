def valid_task_attrs
  {
    :name => "Task Name",
    :due => (Date.today + 1.day),
    :completed => Date.today,
    :time_spent => 1
  }
end

def mock_task(params={})
  object = mock_model(Task, valid_task_attrs.merge(params))
  object.stub_belongs_to_assoc!(:user, params[:user] ? params[:user] : mock_user)
  object.stub_belongs_to_assoc!(:context, params[:context] ? params[:context] : mock_context)
  object.stub_belongs_to_assoc!(:project, params[:project] ? params[:project] : mock_project)
  object.stub!(:permalink).and_return("task-name")
  object
end