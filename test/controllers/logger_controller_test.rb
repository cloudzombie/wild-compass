require 'test_helper'

class LoggerControllerTest < ActionController::TestCase
  test "should get info" do
    get :info
    assert_response :success
  end

  test "should get debug" do
    get :debug
    assert_response :success
  end

  test "should get warn" do
    get :warn
    assert_response :success
  end

  test "should get error" do
    get :error
    assert_response :success
  end

  test "should get fatal" do
    get :fatal
    assert_response :success
  end

  test "should get unknown" do
    get :unknown
    assert_response :success
  end

end
