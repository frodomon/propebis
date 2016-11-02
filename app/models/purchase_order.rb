class PurchaseOrder < ActiveRecord::Base
  validates_presence_of :supplier_id, message: "Debe elegir un proveedor"
  validates_presence_of :business_id, message: "Debe elegir una empresa"
  validates_presence_of :order_number, message: "Debe ingresar el número de orden de compra"
  validates_presence_of :order_date, message: "Debe ingresar la fecha en que se hizo la orden de compra"
  validates_presence_of :delivery_date, message: "Debe ingresar la fecha de entrega de la orden de compra"
  validates_presence_of :billing_address, message: "Debe ingresar la dirección de facturación"
  validates_presence_of :delivery_address, message: "Debe ingresar la dirección de entrega"
  belongs_to :supplier
  belongs_to :business
  has_many :purchase_order_details, dependent: :destroy
  has_many :purchase_order_documents, dependent: :destroy
  accepts_nested_attributes_for :purchase_order_details, allow_destroy: true
  accepts_nested_attributes_for :purchase_order_documents, allow_destroy: true
end
