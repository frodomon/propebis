class RemissionGuidesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show ]
  load_and_authorize_resource
  before_action :set_remission_guide, only: [:show, :edit, :update, :destroy]

  # GET /remission_guides
  # GET /remission_guides.json
  def index
    @remission_guides = RemissionGuide.all
  end

  # GET /remission_guides/1
  # GET /remission_guides/1.json
  def show
  end

  # GET /remission_guides/new
  def new
    @remission_guide = RemissionGuide.new
    @remission_guide.remission_guide_details.build
    @clients = Client.all
    @businesses = Business.all
    @products = Product.all
    @today = Time.now.strftime("%d-%m-%Y")
  end

  # GET /remission_guides/1/edit
  def edit
    @clients = Client.all
    @business = Business.all
    @products = Product.all
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
    client_id = @remission_guide.client_id
    puts client_id
    @contratos = Contract.all
    @contratos.each do |c|
      if c.client_id === client_id
        value = c.credit
        value = value - @remission_guide.ammount
        c.update_attribute(:credit,value)
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
      params.require(:remission_guide).permit(:business_id, :client_id, :driver_id, :vehicle_id, :remission_guide_number, :initial_point, :final_point, :date, :ammount,
        remission_guide_details_attributes: [:id, :remission_guide_id, :product_id, :quantity, :unit_price, :subtotal, :_destroy])
    end
end
