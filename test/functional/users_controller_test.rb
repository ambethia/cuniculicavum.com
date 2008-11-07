require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  def test_should_show_user
    get :show, :id => users(:jasper).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit
    assert_response :success
  end

  def test_should_update_user
    put :update, :user => { }
    assert_redirected_to user_path(assigns(:user))
  end

  def test_should_destroy_user
    @current_user = users(:jasper)
    assert_difference('User.count', -1) do
      delete :destroy
    end

    assert_redirected_to users_path
  end
end
