require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
    assert_equal("downcased@example.com", user.email_address)
  end

  test "requires an email address" do
    user = users(:one).dup
    user.email_address = ""

    assert_not user.valid?
    assert_includes user.errors[:email_address], "can't be blank"
  end

  test "requires a unique email address" do
    user = users(:one).dup
    user.email_address = users(:two).email_address

    assert_not user.valid?
    assert_includes user.errors[:email_address], "has already been taken"
  end

  test "requires a valid email format" do
    user = users(:one).dup
    user.email_address = "not-an-email"

    assert_not user.valid?
    assert_includes user.errors[:email_address], "is invalid"
  end
end
