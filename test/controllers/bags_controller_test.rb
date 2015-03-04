require 'test_helper'

class BagsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @bag = bags(:bag_1)
    @user = users(:su_admin)
  end

  test "should get index" do
    sign_in :user, @user
    
    get :index
    assert_response :success
    assert_not_nil assigns(:bags)
  end

  test "should get new" do
    sign_in :user, @user

    get :new
    assert_response :success
  end

  test "should create bag" do
    sign_in :user, @user

    assert_difference('Bag.count') do
      post :create, bag: { initial_weight: 500.0, current_weight: 500.0 }
    end

    assert_redirected_to bag_path(assigns(:bag))
  end

  test "should show bag" do
    sign_in :user, @user

    get :show, id: @bag
    assert_response :success
  end

  test "should get edit" do
    sign_in :user, @user

    get :edit, id: @bag
    assert_response :success
  end

  test "should update bag" do
    sign_in :user, @user

    patch :update, id: @bag, bag: {  }
    assert_redirected_to bag_path(assigns(:bag))
  end

  test "should destroy bag" do
    sign_in :user, @user
    
    assert_difference('Bag.count', -1) do
      delete :destroy, id: @bag
    end

    assert_redirected_to bags_path
  end
end
