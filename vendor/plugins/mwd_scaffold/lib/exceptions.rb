module Exceptions
  
  class ObjectPermissionDenied < RuntimeError
    attr_reader :message
    def initialize(msg='')
      @message = msg
    end
  end
    
  def catch_errors
    if RAILS_ENV == "development"
      yield and return
    end
    
    begin
      yield      
    rescue ObjectPermissionDenied
      render :file => "public/403.html"
    end
    
  end
    
end
