class SalesOrder < ActiveRecord::Base
  validates_presence_of :client_id, message: "Debe elegir un cliente"
  validates_presence_of :business_id, message: "Debe elegir una empresa"
  validates_presence_of :sales_order_number, message: "Debe ingresar el número de orden de venta"
  validates_presence_of :order_date, message: "Debe ingresar la fecha en que se hizo la orden de compra"
  validates_presence_of :delivery_date, message: "Debe ingresar la fecha de entrega de la orden de compra"
  validates_presence_of :billing_address, message: "Debe ingresar la dirección de facturación"
  validates_presence_of :delivery_address, message: "Debe ingresar la dirección de entrega"
  validates_presence_of :contract_id, message: "Debe elegir un contrato"
  validates_presence_of :ammount, message: "Debe ingresar productos"
  validate :check_contract_credit, on: :create
  belongs_to :business
  belongs_to :client
  has_many :sales_order_details, dependent: :destroy
  has_many :sales_order_documents, dependent: :destroy
  accepts_nested_attributes_for :sales_order_details, allow_destroy: true
  accepts_nested_attributes_for :sales_order_documents, allow_destroy: true

  def check_contract_credit
    if self.ammount.nil? 
      errors.add(:sales_order, 'Debe ingresar productos')
    else
      if self.contract_id.nil? 
        errors.add(:sales_order, 'Debe seleccionar un contrato')
      else
        contract = Contract.find(self.contract_id)  
        if contract.credit < self.ammount
          errors.add(:sales_order, 'No tiene el credito suficiente')
        end
      end
    end
  end
end
