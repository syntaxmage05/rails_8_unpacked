require "test_helper"

class GroupTest < ActiveSupport::TestCase
  test "requires a name" do
    group = Group.new(name: "")

    assert_not group.valid?
    assert_includes group.errors[:name], "can't be blank"
  end
end
