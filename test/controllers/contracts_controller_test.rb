require 'test_helper'

class ContractsControllerTest < ActionController::TestCase
  setup do
    @contract = contracts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contract" do
    assert_difference('Contract.count') do
      post :create, contract: { business_id: @contract.business_id, client_id: @contract.client_id, contract_number: @contract.contract_number, credit: @contract.credit, date: @contract.date, end_date: @contract.end_date, final_price: @contract.final_price, name: @contract.name, start_date: @contract.start_date }
    end

    assert_redirected_to contract_path(assigns(:contract))
  end

  test "should show contract" do
    get :show, id: @contract
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contract
    assert_response :success
  end

  test "should update contract" do
    patch :update, id: @contract, contract: { business_id: @contract.business_id, client_id: @contract.client_id, contract_number: @contract.contract_number, credit: @contract.credit, date: @contract.date, end_date: @contract.end_date, final_price: @contract.final_price, name: @contract.name, start_date: @contract.start_date }
    assert_redirected_to contract_path(assigns(:contract))
  end

  test "should destroy contract" do
    assert_difference('Contract.count', -1) do
      delete :destroy, id: @contract
    end

    assert_redirected_to contracts_path
  end
end
