require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	test "invalid user info" do
		get signup_path
		assert_no_difference "User.count" do
			post users_path, user: {name: "",
															email: "user@invalid",
															password: "bar",
														  password_confirmation: "foo"}
		end
		assert_template 'users/new'
	end

	test "Successful user signup" do
		get signup_path
		assert_difference "User.count",1 do
			post_via_redirect users_path, user: { name: "Example User",
																						email: "example@user.com",
																						password: "123456789",
																					  password_confirmation: "123456789"}
			end
			assert_template 'users/show'
			assert is_logged_in?
	end
end
