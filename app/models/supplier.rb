class Supplier < ActiveRecord::Base
  validates_presence_of :name, message: "Debe ingresar una Razón Social"
  validates_presence_of :ruc, length: { is: 11, message: "Los números RUC tienen 11 digitos" }
  validates_presence_of :address, message: "Debe ingresar una dirección"
  validates_presence_of :telephone, { in: 7..9, message: "Los números de telefono tienen entre 7 y 9 digitos"}
  validates_presence_of :contact, message: "Debe ingresar una persona de contacto"
  has_one :purchase_order
end
