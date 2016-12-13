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
        format.html { 
          flash[:notice] = 'La Adenda se creó satisfactoriamente.'
          redirect_to contract_addendums_path(@addendum.contract_id)
        }
        format.json { render :show, status: :created, location: @addendum }
      else
        format.html {
          flash[:errors] = @addendum.errors
          redirect_to action: :new, contract_id: @addendum.contract_id 
        }
        format.json { render json: @addendum.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @addendum.update(addendum_params)
        format.html { 
          flash[:notice] = 'La Adenda se actualizó satisfactoriamente.'
          redirect_to contract_addendums_path(@addendum.contract_id)
        }
        format.json { render :show, status: :ok, location: @addendum }
      else
        format.html { 
          render :edit 
        }
        format.json { render json: @addendum.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  	@contract = Contract.find(params[:contract_id])
    @addendum = @contract.addendums.find(params[:id])
    @addendum.destroy
    respond_to do |format|
      format.html { 
        flash[:notice] = 'La Adenda se eliminó satisfactoriamente.'
        redirect_to contract_addendums_path(@addendum.contract_id)
      }
      format.json { head :no_content }
    end
  end
  
  def update_credit
    contract = Contract.find(params[:contract_id])
    value = contract.credit
    value = value + @addendum.ammount
    end_date = @addendum.end_date
    contract.update_attribute(:credit,value)
    contract.update_attribute(:end_date,end_date)
    contract.update_attribute(:active,true)
    @addendum.update_attribute(:updated,true)
    contract_details = contract.contract_details
    addendum_details = @addendum.addendum_details
    addendum_details.each do |add|  
      found = false
      contract_details.each do |contract|
        if add.product_id === contract.product_id
          found = true
          new_pending = contract.pending + add.quantity
          contract.update_attribute(:pending, new_pending)
        end
      end
      if found == false
        new_detail = ContractDetail.new(product_id: add.product_id, quantity: add.quantity, pending: add.quantity, unit_price: add.unit_price, subtotal: add.subtotal)
        contract_details << new_detail
      end
    end
    flash[:notice] = 'La Adenda se aplicó satisfactoriamente'
    redirect_to contracts_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @addendum = Addendum.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def addendum_params
      params.require(:addendum).permit(:contract_id, :ammount, :date, :start_date, :end_date, :addendum_number, :_destroy,
        addendum_details_attributes: [:id, :addendum_id, :product_id, :quantity, :unit_price, :subtotal, :_destroy],
        addendum_documents_attributes: [:id, :addendum_id, :document, :_destroy])
    end
end
