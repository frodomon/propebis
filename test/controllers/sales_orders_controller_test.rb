require 'test_helper'

class SalesOrdersControllerTest < ActionController::TestCase
  setup do
    @sales_order = sales_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sales_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sales_order" do
    assert_difference('SalesOrder.count') do
      post :create, sales_order: { billing_address: @sales_order.billing_address, business_id: @sales_order.business_id, client_id: @sales_order.client_id, date: @sales_order.date, delivery_address: @sales_order.delivery_address, delivery_date: @sales_order.delivery_date, order_date: @sales_order.order_date, sales_order_number: @sales_order.sales_order_number }
    end

    assert_redirected_to sales_order_path(assigns(:sales_order))
  end

  test "should show sales_order" do
    get :show, id: @sales_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sales_order
    assert_response :success
  end

  test "should update sales_order" do
    patch :update, id: @sales_order, sales_order: { billing_address: @sales_order.billing_address, business_id: @sales_order.business_id, client_id: @sales_order.client_id, date: @sales_order.date, delivery_address: @sales_order.delivery_address, delivery_date: @sales_order.delivery_date, order_date: @sales_order.order_date, sales_order_number: @sales_order.sales_order_number }
    assert_redirected_to sales_order_path(assigns(:sales_order))
  end

  test "should destroy sales_order" do
    assert_difference('SalesOrder.count', -1) do
      delete :destroy, id: @sales_order
    end

    assert_redirected_to sales_orders_path
  end
end
