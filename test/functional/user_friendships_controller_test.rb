require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
  context "#new" do
  	context "when not logged in" do
  		should "redirect to the login page" do
  			get :new
  			assert_response :redirect
  	  end
  	end
  
  	context "when logged in" do
  		setup do
  			sign_in users(:jason)
  		end

  		should "get new and return success" do
  			get :new
  			assert_response :success
  		end

  	 should "should set a flash error if the friend_id param is missing" do
        get :new, {}
        assert_equal "Friend Required", flash[:error]
      end

  		should "display the friend's name" do
	        get :new, friend_id: users(:jim).id
	        assert_match /#{users(:jim).full_name}/, response.body
      end
      should "assign a user friendship" do
        get :new, friend_id: users(:jim).id
        assert assigns(:user_friendship)
      end
      should "assign a user friendship with the correct friend" do
        get :new, friend_id: users(:jim).id
        assert_equal assigns(:user_friendship).friend, users(:jim)
      end

        should "assign a new user friendship with the currenttly logged in user" do
        	get :new, friend_id: users(:jim).id
        	assert_equal assigns(:user_friendship).user, users(:jason)
      end
        should "display a 404 page if no friend is found" do
          get :new, friend_id: 'invalid'
          assert_response :not_found
      end
  	end
  end
end
