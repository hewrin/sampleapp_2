require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	def setup
		ActionMailer::Base.deliveries.clear
	end

	test "invalid user info" do
		get signup_path
		assert_no_difference "User.count" do
			post users_path, user: {name: "",
															email: "user@invalid",
															password: "bar",
														  password_confirmation: "foo"}
		end
		assert_template 'users/new'
		assert_select 'div#error_explaination'
		assert_select 'li', "Name can't be blank"

	end

	test "Successful user signup info with account activation" do
		get signup_path
		assert_difference "User.count",1 do
			post users_path, user: { name: "Example User",
																						email: "example@user.com",
																						password: "123456789",
																					  password_confirmation: "123456789"}
			end
			assert_equal 1, ActionMailer::Base.deliveries.size
			user = assigns(:user)
			assert_not user.activated?
			log_in_as user
			assert_not is_logged_in?
			get edit_account_activation_path("invalide token")
			assert_not is_logged_in?
			get edit_account_activation_path(user.activation_token, email: user.email)
			assert user.reload.activated?
			follow_redirect!
			assert_template 'users/show'
			assert is_logged_in?
			# assert_template 'users/show'
			# assert is_logged_in?
			# assert_select 'div.alert-success', "Welcome to the Sample App"
			# assert_not flash.empty?

	end
end
