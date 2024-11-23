require "test_helper"

class TodoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get todo_index_url
    assert_response :success
  end

  test "should get create" do
    get todo_create_url
    assert_response :success
  end

  test "should get update" do
    get todo_update_url
    assert_response :success
  end

  test "should get destroy" do
    get todo_destroy_url
    assert_response :success
  end
end
