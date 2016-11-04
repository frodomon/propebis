class SalesOrdersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show ]
  load_and_authorize_resource
  before_action :set_sales_order, only: [:show, :edit, :update, :destroy]

  # GET /sales_orders
  # GET /sales_orders.json
  def index
    @sales_orders = SalesOrder.all
  end

  # GET /sales_orders/1
  # GET /sales_orders/1.json
  def show
  end

  # GET /sales_orders/new
  def new
    @sales_order = SalesOrder.new
    @sales_order.sales_order_details.build
    @sales_order.sales_order_documents.build
    clients_with_contracts
    @contracts = Contract.all
    @products = Product.all
    @today = Time.now.strftime("%d-%m-%Y")
  end

  # GET /sales_orders/1/edit
  def edit
    clients_with_contracts
    @contracts = Contract.all
    @products = Product.all
  end

  # POST /sales_orders
  # POST /sales_orders.json
  def create
    @sales_order = SalesOrder.new(sales_order_params)
    @sales_order.date = Time.now.strftime("%d-%m-%Y")
    respond_to do |format|
      if @sales_order.save
        format.html { redirect_to @sales_order, notice: 'Sales order was successfully created.' }
        format.json { render :show, status: :created, location: @sales_order }
      else
        format.html { redirect_to action: :new }
        format.json { render json: @sales_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales_orders/1
  # PATCH/PUT /sales_orders/1.json
  def update
    respond_to do |format|
      if @sales_order.update(sales_order_params)
        format.html { redirect_to @sales_order, notice: 'Sales order was successfully updated.' }
        format.json { render :show, status: :ok, location: @sales_order }
      else
        format.html { render :edit }
        format.json { render json: @sales_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales_orders/1
  # DELETE /sales_orders/1.json
  def destroy
    @sales_order.destroy
    respond_to do |format|
      format.html { redirect_to sales_orders_url, notice: 'Sales order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_order
      @sales_order = SalesOrder.find(params[:id])
    end

    def clients_with_contracts
      @contratos = Contract.all
      clients = []
      @contratos.each do |c|
        puts c.client_id
        clients << c.client_id
      end
      valid_clients = []
      clients.each do |c_id|
        valid_clients << Client.find(c_id)  
      end
      @clients = valid_clients
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sales_order_params
      params.require(:sales_order).permit(:business_id, :client_id, :contract_id, :ammount, :sales_order_number, :date, :billing_address, :delivery_address, :order_date, :delivery_date,
        sales_order_details_attributes: [:id, :sales_order_id, :product_id, :quantity, :unit_price, :subtotal, :_destroy],
        sales_order_documents_attributes: [:id, :sales_order_id, :document, :_destroy])
    end
end
