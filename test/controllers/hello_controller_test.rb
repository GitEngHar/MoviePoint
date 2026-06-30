require "test_helper"

class HelloControllerTest < ActionDispatch::IntegrationTest
  test "GET /hello returns 200" do
    get "/hello"
    assert_response :success
  end

  test "GET /hello returns Hello123" do
    get "/hello"
    assert_equal "Hello123", response.body
  end
end
