def valid_project_attrs
  {
    :name => "Project Name",
    :note => "Project Note"
  }
end


def mock_project(params={})
  object = mock_model(Project, valid_project_attrs.merge(params))
  object.stub_has_many_assoc!(:tasks, mock_task)
  object.stub_belongs_to_assoc!(:user, params[:user] ? params[:user] : mock_user)
  object.stub!(:permalink).and_return("project-name")
  object
end