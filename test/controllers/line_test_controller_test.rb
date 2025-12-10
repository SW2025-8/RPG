require "test_helper"

class LineTestControllerTest < ActionDispatch::IntegrationTest
  test "should get broadcast" do
    get line_test_broadcast_url
    assert_response :success
  end
end
