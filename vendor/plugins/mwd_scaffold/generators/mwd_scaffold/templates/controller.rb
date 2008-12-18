class <%= controller_class_name %>Controller < ResourceController::Base

  activate do
    action {object.activate!}
    wants.html {redirect_back_or_default(:action=>:index)}
  end

  suspend do
    action {object.suspend!}
    wants.html {redirect_back_or_default(:action=>:index)}
  end    

  destroy do
    action {object.delete!}
    wants.html {redirect_back_or_default(:action=>:index)}
  end

  private

    def object
      @object ||= <%= class_name %>.active.find(param)
    end

    def collection
      @search ||= <%= class_name %>.active.new_search(params[:search])
      @collection, @collection_count = @search.all, @search.count           
      return @collection 
    end

end
