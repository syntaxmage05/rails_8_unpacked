require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @task = tasks(:firts_task)
    sign_in_as(@user)
  end

  test "creates a message for the current user" do
    assert_difference("Message.count", 1) do
      post task_messages_url(@task), params: { message: { content: "Checking in on this task." } }
    end

    message = Message.order(:created_at).last

    assert_redirected_to task_url(@task)
    assert_equal @user, message.user
    assert_equal @task, message.task
    assert_equal "Checking in on this task.", message.content
  end

  test "creates a message with turbo stream" do
    assert_difference("Message.count", 1) do
      post task_messages_url(@task, format: :turbo_stream), params: { message: { content: "Turbo update" } }
    end

    assert_response :success
    assert_equal Mime[:turbo_stream], response.media_type
    assert_includes response.body, "messages_list"
    assert_includes response.body, "Message sent."
  end

  test "renders validation errors with turbo stream" do
    assert_no_difference("Message.count") do
      post task_messages_url(@task, format: :turbo_stream), params: { message: { content: "" } }
    end

    assert_response :unprocessable_content
    assert_equal Mime[:turbo_stream], response.media_type
    assert_includes response.body, "prevented this message from being sent"
  end
end
