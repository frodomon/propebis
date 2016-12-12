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
    @contracts = Contract.where('active = true')
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
  def contracts_index
    @contracts = Contract.where('active = true')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_order
      @sales_order = SalesOrder.find(params[:id])
    end

    def clients_with_contracts
      @contratos = Contract.select([:client_id, :active]).having('active = true').group(:client_id,:active)
      clients = []
      @contratos.each do |c|
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
