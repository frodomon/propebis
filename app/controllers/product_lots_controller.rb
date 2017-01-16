class ProductLotsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show ]
  load_and_authorize_resource
  before_action :set_product_lot, only: [:show, :edit, :update, :destroy]

  # GET /products_lots
  # GET /products_lots.json
  def index
    @product_lots = ProductLot.select("product_id, sum(quantity) as quantity").group("product_id")
  end

  # GET /products_lots/1
  # GET /products_lots/1.json
  def show
  end

  # GET /products_lots/new
  def new
    @product_lot = ProductLot.new
  end

  # GET /products_lots/1/edit
  def edit
  end

  # POST /products_lots
  # POST /products_lots.json
  def create
    @product_lot = ProductLot.new(product_lot_params)

    respond_to do |format|
      if @product_lot.save
        format.html { 
          flash[:notice] = 'El Lote se creó satisfactoriamente.'
          redirect_to product_lots_path
        }
        format.json { render :show, status: :created, location: @product_lot }
      else
        format.html { render :new }
        format.json { render json: @product_lot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products_lots/1
  # PATCH/PUT /products_lots/1.json
  def update
    respond_to do |format|
      if @product_lot.update(product_lot_params)
        format.html { 
          flash[:notice] = 'El Lote se actualizó satisfactoriamente.'
          redirect_to product_lots_path
        }
        format.json { render :show, status: :ok, location: @product_lot }
      else
        format.html { render :edit }
        format.json { render json: @product_lot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products_lots/1
  # DELETE /products_lots/1.json
  def destroy
    @product_lot.destroy
    respond_to do |format|
      format.html { 
        flash[:notice] = 'El Lote se eliminó satisfactoriamente.'
        redirect_to :back
      }
      format.json { head :no_content }
    end
  end

  def lot_by_product
    product_id = params[:product_id]
    @product_lots = ProductLot.where("product_id = ? and quantity > 0",product_id)
  end

  def empty_lots
    product_id = params[:product_id]
    @product_lots = ProductLot.where("product_id = ? and quantity = 0",product_id)
  end

  def all_lots_by_product
    product_id = params[:product_id]
    @product_lots = ProductLot.where("product_id = ?",product_id)
  end

  def search_lots_by_product_front
  end

  def search_lots_by_product
    @product_lots = ProductLot.search(params[:search])
    render :partial => 'search_table'
  end

  def search_lots_close_to_expire_front
  end

  def search_lots_close_to_expire
    @product_lots = ProductLot.search_by_date(params[:search])
    render :partial => 'search_table'    
  end
  def update_from_purchase_order
    @product_lots = []
    2.times do 
      @product_lots << ProductLot.new
    end
    @purchase_orders = PurchaseOrder.select(:id, :order_number).where('registered = false')
    @products = Product.select(:id, :unit_of_measurement)
  end
  def massive_load
    @purchase_orders_warehouse = PurchaseOrderDetail.search_by_id(params[:search]).select(:id, :product_id, :quantity).where('pending > 0')
    
    respond_to do |format|
      format.json { render json: @purchase_orders_warehouse }
    end
  end
  def create_multiple
    params['lotes'].each do |lot|
      if lot['product_id'] != ''
        new_lot = ProductLot.create(lotes_params(lot))
      end
    end
    redirect_to product_lots_path
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_lot
      @product_lot = ProductLot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lotes_params(lot_params)
      lot_params.permit(:product_id, :quantity, :sanitary_registry, :due_date, :lot_number, :production_date, )
    end
    def product_lot_params
      params.require(:product_lot).permit(:quantity, :sanitary_registry, :due_date, :lot_number, :production_date, :product_id)
    end
end
