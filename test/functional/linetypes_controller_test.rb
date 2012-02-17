require 'test_helper'

class LinetypesControllerTest < ActionController::TestCase
  setup do
    @linetype = linetypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:linetypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create linetype" do
    assert_difference('Linetype.count') do
      post :create, :linetype => @linetype.attributes
    end

    assert_redirected_to linetype_path(assigns(:linetype))
  end

  test "should show linetype" do
    get :show, :id => @linetype.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @linetype.to_param
    assert_response :success
  end

  test "should update linetype" do
    put :update, :id => @linetype.to_param, :linetype => @linetype.attributes
    assert_redirected_to linetype_path(assigns(:linetype))
  end

  test "should destroy linetype" do
    assert_difference('Linetype.count', -1) do
      delete :destroy, :id => @linetype.to_param
    end

    assert_redirected_to linetypes_path
  end
end
