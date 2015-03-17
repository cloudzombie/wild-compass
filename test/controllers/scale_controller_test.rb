require 'test_helper'

class ScaleControllerTest < ActionController::TestCase
  test "should get scale" do
    get :scale
    assert_response :success
  end

end
