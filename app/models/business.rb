class Business < ActiveRecord::Base
  validates_presence_of :name, message: "Debe ingresar una Razón Social"
  validates :ruc, length: { is: 11, message: "Los números RUC tienen 11 digitos" }
  validates_presence_of :billing_address, message: "Debe ingresar una dirección de facturación"
  validates_presence_of :delivery_address, message: "Debe ingresar una dirección de envío"
  validates :telephone, length: { in: 7..9, message: "Los números de telefono tienen entre 7 y 9 digitos"}
  validates_presence_of :contact, message: "Debe ingresar una persona de contacto"
  has_one :purchase_order
end
