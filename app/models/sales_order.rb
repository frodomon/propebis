class SalesOrder < ActiveRecord::Base
  validates_presence_of :client_id, message: "Debe elegir un cliente"
  validates_presence_of :business_id, message: "Debe elegir una empresa"
  validates_presence_of :sales_order_number, message: "Debe ingresar el número de orden de venta"
  validates_presence_of :order_date, message: "Debe ingresar la fecha en que se hizo la orden de compra"
  validates_presence_of :delivery_date, message: "Debe ingresar la fecha de entrega de la orden de compra"
  validates_presence_of :billing_address, message: "Debe ingresar la dirección de facturación"
  validates_presence_of :delivery_address, message: "Debe ingresar la dirección de entrega"
  validates_presence_of :ammount, message: "Debe ingresar productos para poder registrar el monto final"
  belongs_to :business
  belongs_to :client
  has_many :sales_order_details, dependent: :destroy
  has_many :sales_order_documents, dependent: :destroy
  has_many :remission_guides
  has_many :control_guides
  accepts_nested_attributes_for :sales_order_details, allow_destroy: true
  accepts_nested_attributes_for :sales_order_documents, allow_destroy: true

end
