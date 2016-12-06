class PurchaseOrdersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show ]
  load_and_authorize_resource
  before_action :set_purchase_order, only: [:print_document, :show, :edit, :update, :destroy]

  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    @purchase_orders = PurchaseOrder.all
  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.json
  def show
  end

  # GET /purchase_orders/new
  def new
    @purchase_order = PurchaseOrder.new
    @purchase_order.purchase_order_details.build
    @purchase_order.purchase_order_documents.build
    @businesses = Business.all
    @products = Product.all
    @today = Time.now.strftime("%Y-%m-%d")
  end

  # GET /purchase_orders/1/edit
  def edit
    @businesses = Business.all
    @products = Product.all
  end

  # POST /purchase_orders
  # POST /purchase_orders.json
  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
    @purchase_order.date = Time.now
    respond_to do |format|
      if @purchase_order.save
        format.html { 
          flash[:notice] = 'La Orden de Compra se creó satisfactoriamente.'
          redirect_to purchase_orders_path
        }
        format.json { render :show, status: :created, location: @purchase_order }
      else
        format.html { render :new }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_orders/1
  # PATCH/PUT /purchase_orders/1.json
  def update
    respond_to do |format|
      if @purchase_order.update(purchase_order_params)
        format.html {
          flash[:notice] = 'La Orden de Compra se actualizó satisfactoriamente.'
          redirect_to purchase_orders_path
        }
        format.json { render :show, status: :ok, location: @purchase_order }
      else
        format.html { render :edit }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.json
  def destroy
    @purchase_order.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = 'La Orden de Compra se eliminó satisfactoriamente.'
        redirect_to purchase_orders_path
      }
      format.json { head :no_content }
    end
  end

  def print_document
    @purchase_order_details = @purchase_order.purchase_order_details
    render :layout => "empty"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_order_params
      params.require(:purchase_order).permit(:supplier_id, :business_id, :order_number, :date, :order_date, :delivery_date, :billing_address, :delivery_address, :ammount, 
        purchase_order_details_attributes: [:id, :purchase_order_id, :product_id, :quantity, :unit_price, :subtotal, :_destroy],
        purchase_order_documents_attributes: [:id, :purchase_order_id, :document, :_destroy])
    end
end
