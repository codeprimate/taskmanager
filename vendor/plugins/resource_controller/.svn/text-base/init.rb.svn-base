ActionController::Base.class_eval do
  include Urligence
  helper_method :smart_url
  
  extend ResourceController::ActionControllerExtension
end

# make helpers available to views
ActionView::Base.class_eval do
  include ResourceController::Helpers
end