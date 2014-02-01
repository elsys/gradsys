require 'test_helper'

class CommitteeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
