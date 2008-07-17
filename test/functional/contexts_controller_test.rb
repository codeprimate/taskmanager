require File.dirname(__FILE__) + '/../test_helper'
require 'contexts_controller'

# Re-raise errors caught by the controller.
class ContextsController; def rescue_action(e) raise e end; end

class ContextsControllerTest < Test::Unit::TestCase
  fixtures :contexts

  def setup
    @controller = ContextsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:contexts)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_context
    old_count = Context.count
    post :create, :context => { }
    assert_equal old_count+1, Context.count
    
    assert_redirected_to context_path(assigns(:context))
  end

  def test_should_show_context
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_context
    put :update, :id => 1, :context => { }
    assert_redirected_to context_path(assigns(:context))
  end
  
  def test_should_destroy_context
    old_count = Context.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Context.count
    
    assert_redirected_to contexts_path
  end
end
