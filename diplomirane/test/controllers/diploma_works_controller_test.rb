require 'test_helper'

class DiplomaWorksControllerTest < ActionController::TestCase
  setup do
    @diploma_work = diploma_works(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:diploma_works)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create diploma_work" do
    assert_difference('DiplomaWork.count') do
      post :create, diploma_work: { approved: @diploma_work.approved, covenanted: @diploma_work.covenanted, description: @diploma_work.description, diploma_supervisor_id: @diploma_work.diploma_supervisor_id, reviewer_id: @diploma_work.reviewer_id, title: @diploma_work.title }
    end

    assert_redirected_to diploma_work_path(assigns(:diploma_work))
  end

  test "should show diploma_work" do
    get :show, id: @diploma_work
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @diploma_work
    assert_response :success
  end

  test "should update diploma_work" do
    patch :update, id: @diploma_work, diploma_work: { approved: @diploma_work.approved, covenanted: @diploma_work.covenanted, description: @diploma_work.description, diploma_supervisor_id: @diploma_work.diploma_supervisor_id, reviewer_id: @diploma_work.reviewer_id, title: @diploma_work.title }
    assert_redirected_to diploma_work_path(assigns(:diploma_work))
  end

  test "should destroy diploma_work" do
    assert_difference('DiplomaWork.count', -1) do
      delete :destroy, id: @diploma_work
    end

    assert_redirected_to diploma_works_path
  end
end
