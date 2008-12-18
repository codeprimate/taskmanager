def valid_context_attra
  {
    :name => "Context Name",
    :note => "Context Note"
  }
end

def mock_context(params={})
  object = mock_model(Context, valid_context_attra)
  object.stub_belongs_to_assoc!(:user, params[:user] ? params[:user] : mock_user)
  object.stub_has_many_ssoc!(:task, params[:task] ? params[:task] : mock_task)
  object.stub!(:permalink).and_return("context-note")
  object
end