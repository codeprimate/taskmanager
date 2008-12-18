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
end