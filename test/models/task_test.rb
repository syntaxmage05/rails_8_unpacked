require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "is valid with fixture attributes" do
    assert tasks(:firts_task).valid?
  end

  test "requires a name" do
    task = tasks(:firts_task).dup
    task.name = ""

    assert_not task.valid?
    assert_includes task.errors[:name], "can't be blank"
  end

  test "requires a description" do
    task = tasks(:firts_task).dup
    task.description = ""

    assert_not task.valid?
    assert_includes task.errors[:description], "can't be blank"
  end

  test "requires a valid status" do
    task = tasks(:firts_task).dup

    assert_raises(ArgumentError) { task.status = "unknown" }
  end
end
