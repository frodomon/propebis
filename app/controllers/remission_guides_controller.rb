class RemissionGuidesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show ]
  load_and_authorize_resource
  before_action :set_remission_guide, only: [:print_document, :show, :edit, :update, :destroy]

  # GET /remission_guides
  # GET /remission_guides.json
  def index
    @remission_guides = RemissionGuide.all
  end

  # GET /remission_guides/1
  # GET /remission_guides/1.json
  def show
    @remission_guide_details = @remission_guide.remission_guide_details
  end

  # GET /remission_guides/new
  def new
    @remission_guide = RemissionGuide.new
    @remission_guide.remission_guide_details.build
    @clients = Client.select('DISTINCT clients.id, clients.name, clients.delivery_address, clients.billing_address').joins("LEFT JOIN sales_orders ON clients.id = sales_orders.client_id").where('status = 0 or status = 2')
    @businesses = Business.all
    @products = Product.all
    @today = Time.now.strftime("%d-%m-%Y")
    @sales_orders = SalesOrder.where('status = 0 or status = 2')
  end

  # GET /remission_guides/1/edit
  def edit
    @clients = Client.select('DISTINCT clients.id, clients.name, clients.delivery_address, clients.billing_address').joins("LEFT JOIN sales_orders ON clients.id = sales_orders.client_id").where('status = 0 or status = 2')
    @business = Business.all
    @products = Product.all
    @sales_orders = SalesOrder.where('status = 0 or status = 2')
  end

  # POST /remission_guides
  # POST /remission_guides.json
  def create
    @remission_guide = RemissionGuide.new(remission_guide_params)
    @remission_guide.date = Time.now
    respond_to do |format|
      if @remission_guide.save
        update_credit
        format.html {
          flash[:notice] = 'La Guía de Remisión se creó satisfactoriamente.'
          redirect_to remission_guides_path
        }
        format.json { render :show, status: :created, location: @remission_guide }
      else
        format.html { 
          flash[:error] = @remission_guide.errors
          redirect_to new_remission_guide_path
        }
        format.json { render json: @remission_guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /remission_guides/1
  # PATCH/PUT /remission_guides/1.json
  def update
    respond_to do |format|
      if @remission_guide.update(remission_guide_params)
        format.html { 
          flash[:notice] = 'La Guía de Remisión se actualizó satisfactoriamente.'
          redirect_to remission_guides_path
        }
        format.json { render :show, status: :ok, location: @remission_guide }
      else
        format.html { render :edit }
        format.json { render json: @remission_guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /remission_guides/1
  # DELETE /remission_guides/1.json
  def destroy
    @remission_guide.destroy
    respond_to do |format|
      format.html { 
        flash[:notice] = 'La Guía de Remisión se eliminó satisfactoriamente.'
        redirect_to remission_guides_path
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
  def update_credit
    sod_id = @remission_guide.sales_order_id
    sales_order = SalesOrder.find(sod_id)
    if sales_order.status == 0
      sales_order.update_attribute(:status, 1)
    elsif sales_order.status == 2
      sales_order.update_attribute(:status, 3)
    end
    if sales_order.contract_id != 0
      contrato = Contract.find(sales_order.contract_id)
      value = contrato.credit
      value = value - @remission_guide.ammount
      if value >= 0
        contrato.update_attribute(:credit,value)
        if  value == 0
          contrato.update_attribute(:active,false)
        end
      end
      contract_details = contrato.contract_details
      remission_guide_details = @remission_guide.remission_guide_details
      remission_guide_details.each do |rgd|  
        contract_details.each do |contract|
          if rgd.product_id == contract.product_id
            new_pending = contract.pending - rgd.quantity
            contract.update_attribute(:pending, new_pending)
          end
        end
      end
    end
  end
  def print_document
    @remission_guide_details = @remission_guide.remission_guide_details
    respond_to do |format|
      format.html {
        render :layout => "empty"
      }
      format.pdf do
        pdf = Pdf.new(@remission_guide, @remission_guide_details)
        send_data pdf.render, filename: "orden_nro_#{@remission_guide.remission_guide_number}.pdf",
                              type: 'application/pdf', disposition: "inline"
      end
    end
  end

  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_remission_guide
      @remission_guide = RemissionGuide.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def remission_guide_params
      params.require(:remission_guide).permit(:business_id, :client_id, :driver_id, :vehicle_id, :sales_order_id, :remission_guide_number, :initial_point, :final_point, :date, :ammount,
        remission_guide_details_attributes: [:id, :remission_guide_id, :product_id, :quantity, :unit_price, :subtotal, :_destroy])
    end
end
