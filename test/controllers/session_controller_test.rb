require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "should get is_logged_in route" do
    get :is_logged_in
    assert_response :success
  end

  test "should post to login route" do
    assert_response :success
  end


end
