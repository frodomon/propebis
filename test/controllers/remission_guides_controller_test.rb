require 'test_helper'

class RemissionGuidesControllerTest < ActionController::TestCase
  setup do
    @remission_guide = remission_guides(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:remission_guides)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create remission_guide" do
    assert_difference('RemissionGuide.count') do
      post :create, remission_guide: { business_id: @remission_guide.business_id, client_id: @remission_guide.client_id, date: @remission_guide.date, driver_id: @remission_guide.driver_id, final_point: @remission_guide.final_point, initial_point: @remission_guide.initial_point, remission_guide_number: @remission_guide.remission_guide_number, vehicle_id: @remission_guide.vehicle_id }
    end

    assert_redirected_to remission_guide_path(assigns(:remission_guide))
  end

  test "should show remission_guide" do
    get :show, id: @remission_guide
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @remission_guide
    assert_response :success
  end

  test "should update remission_guide" do
    patch :update, id: @remission_guide, remission_guide: { business_id: @remission_guide.business_id, client_id: @remission_guide.client_id, date: @remission_guide.date, driver_id: @remission_guide.driver_id, final_point: @remission_guide.final_point, initial_point: @remission_guide.initial_point, remission_guide_number: @remission_guide.remission_guide_number, vehicle_id: @remission_guide.vehicle_id }
    assert_redirected_to remission_guide_path(assigns(:remission_guide))
  end

  test "should destroy remission_guide" do
    assert_difference('RemissionGuide.count', -1) do
      delete :destroy, id: @remission_guide
    end

    assert_redirected_to remission_guides_path
  end
end
