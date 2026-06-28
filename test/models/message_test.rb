require "test_helper"

class MessageTest < ActiveSupport::TestCase
  test "is valid with fixture attributes" do
    assert messages(:one).valid?
  end

  test "requires content" do
    message = messages(:one).dup
    message.content = ""

    assert_not message.valid?
    assert_includes message.errors[:content], "can't be blank"
  end

  test "limits content length" do
    message = messages(:one).dup
    message.content = "a" * 1_001

    assert_not message.valid?
    assert_includes message.errors[:content], "is too long (maximum is 1000 characters)"
  end

  test "broadcasts message updates to the task stream" do
    task = tasks(:firts_task)
    user = users(:one)

    message = nil
    assert_difference("Message.count", 1) do
      message = task.messages.create!(content: "Streaming update", user: user)
    end

    assert_equal task.id, message.task_id
    assert_equal user.id, message.user_id
    assert_equal "Streaming update", message.content
  end
end
