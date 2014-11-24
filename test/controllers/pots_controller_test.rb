require 'test_helper'

class PotsControllerTest < ActionController::TestCase
  setup do
    @pot = pots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pot" do
    assert_difference('Pot.count') do
      post :create, pot: {  }
    end

    assert_redirected_to pot_path(assigns(:pot))
  end

  test "should show pot" do
    get :show, id: @pot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pot
    assert_response :success
  end

  test "should update pot" do
    patch :update, id: @pot, pot: {  }
    assert_redirected_to pot_path(assigns(:pot))
  end

  test "should destroy pot" do
    assert_difference('Pot.count', -1) do
      delete :destroy, id: @pot
    end

    assert_redirected_to pots_path
  end
end
