class ControlGuidesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show ]
  load_and_authorize_resource
  before_action :set_control_guide, only: [:print_document, :show, :edit, :update, :destroy]

  # GET /control_guides
  # GET /control_guides.json
  def index
    @control_guides = ControlGuide.all
  end

  # GET /control_guides/1
  # GET /control_guides/1.json
  def show
    @control_guide_details = @control_guide.control_guide_details
  end

  # GET /control_guides/new
  def new
    @control_guide = ControlGuide.new
    @control_guide.control_guide_details.build
    @clients = Client.select('DISTINCT clients.id, clients.name, clients.delivery_address, clients.billing_address').joins("LEFT JOIN sales_orders ON clients.id = sales_orders.client_id").where('status < 2')
    @businesses = Business.all
    @products = Product.all
    @today = Time.now.strftime("%d-%m-%Y")
    @sales_orders = SalesOrder.where('status < 2')
  end

  # GET /control_guides/1/edit
  def edit
    @clients = Client.select('DISTINCT clients.id, clients.name, clients.delivery_address, clients.billing_address').joins("LEFT JOIN sales_orders ON clients.id = sales_orders.client_id").where('status < 2')
    @businesses = Business.all
    @products = Product.all
    @sales_orders = SalesOrder.where('status < 2')
  end

  # POST /control_guides
  # POST /control_guides.json
  def create
    @control_guide = ControlGuide.new(control_guide_params)
    @control_guide.date = Time.now
    respond_to do |format|
      if @control_guide.save
        update_warehouse
        format.html {
          flash[:notice] = 'La Guía de Remisión Interna se creó satisfactoriamente.'
          redirect_to control_guides_path
        }
        format.json { render :show, status: :created, location: @control_guide }
      else
        format.html { 
          flash[:error] = @control_guide.errors
          redirect_to new_control_guide_path
        }
        format.json { render json: @control_guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /control_guides/1
  # PATCH/PUT /control_guides/1.json
  def update
    respond_to do |format|
      if @control_guide.update(control_guide_params)
        format.html {
          flash[:notice] = 'La Guía de Remisión Interna se actualizó satisfactoriamente.'
          redirect_to control_guides_path
        }
        format.json { render :show, status: :ok, location: @control_guide }
      else
        format.html { render :edit }
        format.json { render json: @control_guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /control_guides/1
  # DELETE /control_guides/1.json
  def destroy
    @control_guide.destroy
    respond_to do |format|
      format.html { 
        flash[:notice] = 'La Guía de Remisión Interna se eliminó satisfactoriamente.'
        redirect_to control_guides_path
      }
      format.json { head :no_content }
    end
  end

  def search_sales_order_details
    @sales_order_details = SalesOrderDetail.search_details(params[:search])
    respond_to do |format|
      format.json { render json: @sales_order_details }
    end
  end
  def update_warehouse
    sod_id = @control_guide.sales_order_id
    sales_order = SalesOrder.find(sod_id)
    if sales_order.status == 0
      sales_order.update_attribute(:status, 2)
    elsif sales_order.status == 1
      sales_order.update_attribute(:status, 3)
    end
    almacen = ProductLot.where('quantity > 0').order('product_id, due_date ASC')
    control_guide_details = @control_guide.control_guide_details
    control_guide_details.each do |cgd|  
      pedido = cgd.quantity
      almacen.each do |alm|
        if cgd.product_id == alm.product_id
          cantidad = alm.quantity
          if pedido > 0  
            if cantidad < pedido
              pedido -= cantidad
              cantidad = 0
            elsif cantidad == pedido
              pedido = 0
              cantidad = 0
            elsif cantidad > pedido
              cantidad -= pedido
              pedido = 0
            end
            alm.update_attribute(:quantity,cantidad)
          end
        end
      end
    end
  end
  def print_document
    @control_guide_details = @control_guide.control_guide_details
    size = params[:size]
    respond_to do |format|
      format.html {
        render :layout => "empty"
      }
      format.pdf do
        pdf = Pdf.new(@control_guide, @control_guide_details, size )
        send_data pdf.render, filename: "guia_interna_nro_#{@control_guide.control_guide_number}.pdf",
                              type: 'application/pdf', disposition: "inline"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_control_guide
      @control_guide = ControlGuide.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def control_guide_params
      params.require(:control_guide).permit(:business_id, :client_id, :driver_id, :vehicle_id, :sales_order_id, :control_guide_number, :initial_point, :final_point, :date, :ammount,
        control_guide_details_attributes: [:id, :control_guide_id, :product_id, :quantity, :unit_price, :subtotal, :_destroy])
    end
end
