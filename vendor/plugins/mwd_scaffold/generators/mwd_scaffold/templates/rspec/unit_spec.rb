require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * controller_class_nesting_depth %>/../spec_helper')

module <%= class_name %>SpecHelper

  def object_with_valid_attributes
    {
      <%- for attribute in attributes -%><% unless attribute.name =~ /_id/ || [:datetime, :timestamp, :time, :date].index(attribute.type) -%>
        :<%= attribute.name -%> => <%= attribute.default_value %>,
      <%- end -%><%- end -%>
    }
  end
  
end
 
#model validation tests
describe <%= class_name %> do

  include <%= class_name %>SpecHelper
  
  before(:each) do
    @object = <%= class_name %>.new
    @object.attributes = object_with_valid_attributes
  end
 
  it "should be valid" do
    @object.should be_valid
  end

end


#model statemachine tests
describe <%= class_name %> do
  
  include <%= class_name %>SpecHelper
  
  before(:each) do
    @object = <%= class_name %>.new
    @object.attributes = object_with_valid_attributes
    @object.save
  end
  
  it "should be created in the active state" do
    @object.state.should == "active"
  end
    
  it "should successfully be marked as suspended" do
    @object.suspend!
    @object.state.should == "suspended"
  end
  
  it "should successfully be marked as active" do
    @object.suspend!
    @object.state.should == "suspended"
    @object.activate!
    @object.state.should == "active"
  end
  
end