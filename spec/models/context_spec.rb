require File.dirname(__FILE__) + '/../spec_helper'

# Model Validation Tests
describe Context do

  before(:each) do
    @object = Context.new
    @object.attributes = valid_context_attrs
    @object.user = mock_user
  end

  it "should be valid" do
    @object.should be_valid
  end

  it "should validate the presence of name" do
    @object.should validate_presence_of(:name)
  end

end

# Instance method tests
describe Context do
  
  before(:each) do
    @object = mock_context
  end

end