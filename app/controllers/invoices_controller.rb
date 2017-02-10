class InvoicesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show ]
  load_and_authorize_resource
  before_action :set_invoice, only: [:print_document, :show, :edit, :update, :destroy]
  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all
  end
  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice_details = @invoice.invoice_details
  end
  # GET /invoices/new
  def new
    @invoice = Invoice.new
    @invoice.invoice_details.build
    @clients = Client.select('DISTINCT clients.id, clients.name, clients.delivery_address, clients.billing_address').joins("LEFT JOIN sales_orders ON clients.id = sales_orders.client_id").where('sales_orders.status > 0 and sales_orders.status < 4 ')
    @businesses = Business.all
    @products = Product.all
    @today = Time.now.strftime("%d-%m-%Y")
    @sales_orders = SalesOrder.where('status > 0 and sales_orders.status < 4')
  end
  # GET /invoices/1/edit
  def edit
    @clients = Client.select('DISTINCT clients.id, clients.name, clients.delivery_address, clients.billing_address').joins("LEFT JOIN sales_orders ON clients.id = sales_orders.client_id").where('sales_orders.status > 0 and sales_orders.status < 4')
    @businesses = Business.all
    @products = Product.all
    @sales_orders = SalesOrder.where('status > 0 and sales_orders.status < 4')
  end
  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.date = Time.now
    respond_to do |format|
      if @invoice.save
        update_status
        format.html {
          flash[:notice] = 'La Factura Interna se creó satisfactoriamente.'
          redirect_to invoices_path
        }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html {
          flash[:error] = @invoice.errors
          redirect_to new_invoice_path
        }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { 
          flash[:notice] = 'La Factura se actualizó satisfactoriamente.'
          redirect_to invoices_path
        }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { 
        flash[:notice] = 'La Factura se eliminó satisfactoriamente.'
        redirect_to invoices_path
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
  def update_status
    sod_id = @invoice.sales_order_id
    sales_order = SalesOrder.find(sod_id)
    sales_order.update_attribute(:status, 4)
  end
  def print_document
    @invoice_details = @invoice.invoice_details
    size = params[:size]
    exonerado = params[:exo]
    respond_to do |format|
      format.html {
        render :layout => "empty"
      }
      format.pdf do
        pdf = Pdf.new(@invoice, @invoice_details, size, exonerado)
        send_data pdf.render, filename: "factura_nro_#{@invoice.invoice_number}.pdf",
                              type: 'application/pdf', disposition: "inline"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:business_id, :client_id, :sales_order_id, :invoice_number, :date, :ammount,
        invoice_details_attributes: [:id, :invoice_id, :product_id, :quantity, :unit_price, :subtotal, :_destroy])
    end
end
