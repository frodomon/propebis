require 'test_helper'

class ControlGuidesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @control_guide = control_guides(:one)
  end

  test "should get index" do
    get control_guides_url
    assert_response :success
  end

  test "should get new" do
    get new_control_guide_url
    assert_response :success
  end

  test "should create control_guide" do
    assert_difference('ControlGuide.count') do
      post control_guides_url, params: { control_guide: { ammount: @control_guide.ammount, bussines_id: @control_guide.bussines_id, client: @control_guide.client, control_guide_number: @control_guide.control_guide_number, date: @control_guide.date, driver_id: @control_guide.driver_id, final_point: @control_guide.final_point, initial_point: @control_guide.initial_point, sales_order_id: @control_guide.sales_order_id, vehicle_id: @control_guide.vehicle_id } }
    end

    assert_redirected_to control_guide_url(ControlGuide.last)
  end

  test "should show control_guide" do
    get control_guide_url(@control_guide)
    assert_response :success
  end

  test "should get edit" do
    get edit_control_guide_url(@control_guide)
    assert_response :success
  end

  test "should update control_guide" do
    patch control_guide_url(@control_guide), params: { control_guide: { ammount: @control_guide.ammount, bussines_id: @control_guide.bussines_id, client: @control_guide.client, control_guide_number: @control_guide.control_guide_number, date: @control_guide.date, driver_id: @control_guide.driver_id, final_point: @control_guide.final_point, initial_point: @control_guide.initial_point, sales_order_id: @control_guide.sales_order_id, vehicle_id: @control_guide.vehicle_id } }
    assert_redirected_to control_guide_url(@control_guide)
  end

  test "should destroy control_guide" do
    assert_difference('ControlGuide.count', -1) do
      delete control_guide_url(@control_guide)
    end

    assert_redirected_to control_guides_url
  end
end
