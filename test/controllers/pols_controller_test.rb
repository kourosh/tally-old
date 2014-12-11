require 'test_helper'

class PolsControllerTest < ActionController::TestCase
  setup do
    @pol = pols(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pols)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pol" do
    assert_difference('Pol.count') do
      post :create, pol: {  }
    end

    assert_redirected_to pol_path(assigns(:pol))
  end

  test "should show pol" do
    get :show, id: @pol
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pol
    assert_response :success
  end

  test "should update pol" do
    patch :update, id: @pol, pol: {  }
    assert_redirected_to pol_path(assigns(:pol))
  end

  test "should destroy pol" do
    assert_difference('Pol.count', -1) do
      delete :destroy, id: @pol
    end

    assert_redirected_to pols_path
  end
end
