class Invoice < ApplicationRecord
  validates_presence_of :business_id, message: "Debe elegir una empresa"
  validates_presence_of :client_id, message: "Debe elegir un cliente"
  validates_presence_of :invoice_number, message: "Debe ingresar el número de factura"
  validates_presence_of :date, message: "Debe ingresar la fecha de la guía de remisión"

  belongs_to :business
  belongs_to :client
  belongs_to :sales_order
  has_many :invoice_details, dependent: :destroy
  accepts_nested_attributes_for :invoice_details, allow_destroy: true
end
