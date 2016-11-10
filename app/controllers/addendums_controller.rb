class AddendumsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show ]
  load_and_authorize_resource
  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy, :update_credit]

  def index
    @addendums = Addendum.where('contract_id =?',params[:contract_id])
  end

  def show
  end

  def new
  	@contract = Contract.find(params[:contract_id])
    @addendum = @contract.addendums.build
    @addendum.addendum_details.build
    @addendum.addendum_documents.build
    @products = Product.all
  end

  def edit
  	@contract = Contract.find(params[:contract_id])
    @addendum = @contract.addendums.find(params[:id])
    @products = Product.all
  end

  def create
    @addendum = Addendum.new(addendum_params)

    respond_to do |format|
      if @addendum.save
        format.html { redirect_to contracts_url, notice: 'Addendum was successfully created.' }
        format.json { render :show, status: :created, location: @addendum }
      else
        format.html { render :new }
        format.json { render json: @addendum.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @addendum.update(addendum_params)
        format.html { redirect_to contract_addendums_url(@addendum.contract_id), notice: 'Addendum was successfully updated.' }
        format.json { render :show, status: :ok, location: @addendum }
      else
        format.html { render :edit }
        format.json { render json: @addendum.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  	@contract = Contract.find(params[:contract_id])
    @addendum = @contract.addendums.find(params[:id])
    @addendum.destroy
    respond_to do |format|
      format.html { redirect_to contract_addendums_url(@addendum.contract_id), notice: 'Addendum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def update_credit
    @contract = Contract.find(params[:contract_id])
    value = @contract.credit
    value = value + @addendum.ammount
    @contract.update_attribute(:credit,value)
    @addendum.update_attribute(:updated,true)
    redirect_to contracts_url, notice: 'Contract credit was successfully updated.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @addendum = Addendum.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def addendum_params
      params.require(:addendum).permit(:contract_id, :ammount, :date, :addendum_number, :_destroy,
        addendum_details_attributes: [:id, :addendum_id, :product_id, :quantity, :unit_price, :subtotal, :_destroy],
        addendum_documents_attributes: [:id, :addendum_id, :document, :_destroy])
    end
end
