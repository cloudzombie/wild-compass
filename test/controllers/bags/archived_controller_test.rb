require 'test_helper'

class Bags::ArchivedControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

end
