class ContractsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show ]
  load_and_authorize_resource
  before_action :set_contract, only: [:show, :edit, :update, :destroy]

  # GET /contracts
  # GET /contracts.json
  def index
    @contracts = Contract.all
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
    @contract.contract_details.build
    @contract.contract_documents.build
    @products = Product.all
    @today = Time.now.strftime("%d-%m-%Y")
  end

  # GET /contracts/1/edit
  def edit
    @products = Product.all
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)
    @contract.date = Time.now
    @contract.credit = @contract.final_price
    respond_to do |format|
      if @contract.save
        format.html { 
          flash[:notice] = 'El Contrato se creó satisfactoriamente.'
          redirect_to contracts_path
        }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { 
          flash[:notice] = 'El Contrato se actualizó satisfactoriamente.'
          redirect_to contracts_path
        }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { 
          redirect_to edit_contract_path(@contract) }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { 
        flash[:notice] = 'El Contrato se eliminó satisfactoriamente.'
        redirect_to contracts_path
      }
      format.json { head :no_content }
    end
  end

  def show_addendums
    @addendums = Addendum.where('contract_id = ?',params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.require(:contract).permit(:client_id, :business_id, :contract_number, :date, :start_date, :end_date, :final_price, :credit, :active,
        contract_details_attributes: [:id, :contract_id, :product_id, :quantity, :pending, :unit_price, :subtotal, :_destroy],
        contract_documents_attributes: [:id, :contract_id, :document, :_destroy])
    end
end
