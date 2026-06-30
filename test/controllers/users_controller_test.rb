require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # index
  test "GET /users returns 200 and all users as JSON" do
    get "/users"
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal User.count, json.length
  end

  # show
  test "GET /users/:id returns 200 and the matching user as JSON" do
    user = users(:one)
    get "/users/#{user.user_id}"
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal user.user_id, json["user_id"]
    assert_equal user.name, json["name"]
    assert_equal user.age, json["age"]
  end

  test "GET /users/:id returns null when user not found" do
    get "/users/nonexistent_id"
    assert_response :success
    assert_nil JSON.parse(response.body)
  end

  # create
  test "POST /users creates a user and returns 201" do
    assert_difference("User.count", 1) do
      post "/users", params: { user_id: "user003", name: "Carol", age: 20 }
    end
    assert_response :created
    json = JSON.parse(response.body)
    assert_equal "user003", json["user_id"]
    assert_equal "Carol", json["name"]
    assert_equal 20, json["age"]
  end

  # update
  test "PATCH /users/:id updates the user and returns 202" do
    user = users(:one)
    patch "/users/#{user.user_id}", params: { name: "Alice Updated" }
    assert_response :accepted
    json = JSON.parse(response.body)
    assert_equal "Alice Updated", json["name"]
  end

  # destroy
  test "DELETE /users/:id deletes the user and returns 202" do
    user = users(:one)
    assert_difference("User.count", -1) do
      delete "/users/#{user.user_id}"
    end
    assert_response :accepted
  end
end
