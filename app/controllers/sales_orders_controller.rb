class SalesOrdersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show ]
  load_and_authorize_resource
  before_action :set_sales_order, only: [:print_document, :show, :edit, :update, :destroy]

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
    @sales_orders = SalesOrder.where('status = 0')
    @clients = Client.select(:id, :name, :delivery_address, :billing_address)
    @clients_with_contracts = Client.select('DISTINCT clients.id, clients.name, clients.delivery_address, billing_address').joins(:contracts).where('contracts.active = true')
    @clients_without_contracts = Client.select('DISTINCT clients.id, clients.name, clients.delivery_address, billing_address').joins("LEFT JOIN contracts ON clients.id = contracts.client_id").where('contracts.client_id is NULL')      
    @contracts = Contract.select(:id, :contract_number, :client_id,:business_id, :credit).where('active = true')
    @products = Product.all
    @today = Time.now.strftime("%d-%m-%Y")
  end

  # GET /sales_orders/1/edit
  def edit
    @clients = Client.select(:id, :name)
    @contracts = Contract.select(:id, :contract_number, :client_id, :business_id, :credit).where('active = true')
    @products = Product.all
  end

  # POST /sales_orders
  # POST /sales_orders.json
  def create
    @sales_order = SalesOrder.new(sales_order_params)
    @sales_order.date = Time.now
    respond_to do |format|
      if @sales_order.save
        format.html {
          flash[:notice] = 'La Orden de Venta se creó satisfactoriamente.'
          redirect_to sales_orders_path
        }
        format.json { render :show, status: :created, location: @sales_order }
      else
        format.html { 
          flash[:error] = @sales_order.errors
          redirect_to new_sales_order_path
        }
        format.json { render json: @sales_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales_orders/1
  # PATCH/PUT /sales_orders/1.json
  def update
    respond_to do |format|
      if @sales_order.update(sales_order_params)
        format.html { 
          flash[:notice] = 'La Orden de Venta se actualizó satisfactoriamente.'
          redirect_to sales_orders_path
        }
        format.json { render :show, status: :ok, location: @sales_order }
      else
        format.html { 
          flash[:error] = @sales_order.errors
          redirect_to edit_sales_order_path(@sales_order.id)
        }
        format.json { render json: @sales_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales_orders/1
  # DELETE /sales_orders/1.json
  def destroy
    @sales_order.destroy
    respond_to do |format|
      format.html { 
        flash[:notice] = 'La Orden de Venta se eliminó satisfactoriamente.'
        redirect_to sales_orders_path
      }
      format.json { head :no_content }
    end
  end
  def search_contract_details
    @contract_details = ContractDetail.search_details(params[:search])
    respond_to do |format|
      format.json { render json: @contract_details }
    end
  end
  def print_document
    @sales_order_details = @sales_order.sales_order_details
    render :layout => "empty"
  end
  def search_stock_for_product
    @product = ProductLot.select("product_id, sum(quantity) as quantity").group("product_id").where('product_id = ?',params[:p_id])
    respond_to do |format|
      format.json { render json: @product}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_order
      @sales_order = SalesOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sales_order_params
      params.require(:sales_order).permit(:business_id, :client_id, :contract_id, :ammount, :sales_order_number, :date, :billing_address, :delivery_address, :order_date, :delivery_date, :siaf_number, :status,
        sales_order_details_attributes: [:id, :sales_order_id, :product_id, :quantity, :unit_price, :subtotal, :_destroy],
        sales_order_documents_attributes: [:id, :sales_order_id, :document, :_destroy])
    end
end
