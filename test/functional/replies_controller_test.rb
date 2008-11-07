require 'test_helper'

class RepliesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index, :topic_id => topics(:lorem_ipsum).id
    assert_response :success
    assert_not_nil assigns(:replies)
  end

  def test_should_get_new
    get :new, :topic_id => topics(:lorem_ipsum).id
    assert_response :success
  end

  def test_should_create_reply
    assert_difference('Reply.count') do
      post :create, :topic_id => topics(:lorem_ipsum).id, :reply => { }
    end

    assert_redirected_to topic_path(topics(:lorem_ipsum))
  end

  def test_should_show_reply
    get :show, :id => replies(:jasper).id, :topic_id => topics(:lorem_ipsum).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => replies(:jasper).id, :topic_id => topics(:lorem_ipsum).id
    assert_response :success
  end

  def test_should_update_reply
    put :update, :id => replies(:jasper).id, :topic_id => topics(:lorem_ipsum).id, :reply => { }
    assert_redirected_to topic_path(topics(:lorem_ipsum))
  end

  def test_should_destroy_reply
    assert_difference('Reply.count', -1) do
      delete :destroy, :id => replies(:jasper).id, :topic_id => topics(:lorem_ipsum).id
    end

    assert_redirected_to topic_path(topics(:lorem_ipsum))
  end
end
