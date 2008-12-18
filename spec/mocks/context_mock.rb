def valid_context_attrs
  {
    :name => "Context Name",
    :note => "Context Note"
  }
end

def mock_context(params={})
  object = mock_model(Context, valid_context_attrs.merge(params))
  object.stub_belongs_to_assoc!(:user)
  object.stub_has_many_assoc!(:task)
  object.stub!(:permalink).and_return("context-note")
  object
end