require 'test_helper'

class ScanControllerTest < ActionController::TestCase
  test "should get scan" do
    get :scan
    assert_response :success
  end

end
