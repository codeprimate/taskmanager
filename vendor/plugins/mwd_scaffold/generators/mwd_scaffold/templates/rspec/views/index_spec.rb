require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * controller_class_nesting_depth %>/../../spec_helper')
 
describe "/<%= table_name %>/index.html.erb" do

  include <%= controller_class_name %>Helper

  before(:each) do
    <%- [98,99].each do |id| -%>
    <%= file_name %>_<%= id %> = mock_model(<%= class_name %>)
    <%- for attribute in attributes -%>
    <%= file_name %>_<%= id %>.should_receive(:<%= attribute.name %>).and_return(<%= attribute.default_value %>)
    <%- end -%>
    <%= file_name %>_<%= id %>.stub!(:active?).and_return(true)    
    <%- end %>

    assigns[:collection_count] = 2
    assigns[:<%= table_name %>] = [<%= file_name %>_98, <%= file_name %>_99]

    search = <%= class_name %>.new_search
    search.per_page = 25
    search.page = 1
    search.all

    assigns[:search] = search

    template.stub!(:order_by_link).and_return("")
    template.stub!(:per_page_select).and_return("")

    template.stub!(:object).and_return(<%= file_name %>_98)
    template.stub!(:collection).and_return([<%= file_name %>_98, <%= file_name %>_99])

    template.stub!(:object_url).and_return(<%= file_name %>_url(<%= file_name %>_98))
    template.stub!(:object_path).and_return(<%= file_name %>_path(<%= file_name %>_98))
    template.stub!(:new_object_url).and_return(new_<%= file_name %>_url)
    template.stub!(:new_object_path).and_return(new_<%= file_name %>_path)
    template.stub!(:edit_object_url).and_return(edit_<%= file_name %>_url(<%= file_name %>_98))
    template.stub!(:edit_object_path).and_return(edit_<%= file_name %>_path(<%= file_name %>_98))
    template.stub!(:collection_url).and_return(<%= file_name.pluralize %>_url)
    template.stub!(:collection_path).and_return(<%= file_name.pluralize %>_path)
 
  end
 
  it "should render list of <%= table_name %>" do
    render "/<%= table_name %>/index.html.erb"
    <%- for attribute in attributes -%><%- unless attribute.name =~ /_id/ || [:datetime, :timestamp, :time, :date].index(attribute.type) -%>
    response.should have_tag("tr>td", <%= attribute.default_value %>, 2)
    <%- end -%><%- end -%>
  end

end