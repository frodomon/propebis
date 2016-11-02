require 'test_helper'

class ProductsLotsControllerTest < ActionController::TestCase
  setup do
    @products_lot = products_lots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products_lots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create products_lot" do
    assert_difference('ProductsLot.count') do
      post :create, products_lot: { due_date: @products_lot.due_date, lot_number: @products_lot.lot_number, product_id: @products_lot.product_id, production_date: @products_lot.production_date, quantity: @products_lot.quantity, sanitary_registry: @products_lot.sanitary_registry }
    end

    assert_redirected_to products_lot_path(assigns(:products_lot))
  end

  test "should show products_lot" do
    get :show, id: @products_lot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @products_lot
    assert_response :success
  end

  test "should update products_lot" do
    patch :update, id: @products_lot, products_lot: { due_date: @products_lot.due_date, lot_number: @products_lot.lot_number, product_id: @products_lot.product_id, production_date: @products_lot.production_date, quantity: @products_lot.quantity, sanitary_registry: @products_lot.sanitary_registry }
    assert_redirected_to products_lot_path(assigns(:products_lot))
  end

  test "should destroy products_lot" do
    assert_difference('ProductsLot.count', -1) do
      delete :destroy, id: @products_lot
    end

    assert_redirected_to products_lots_path
  end
end
