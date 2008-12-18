def valid_user_attrs
  {
    :login => "Login",
    :name => "User Name",
    :email => "user_email@example.com"
  }
end

def mock_user(params={})
  object = mock_model(User, valid_user_attrs.merge(params))

end