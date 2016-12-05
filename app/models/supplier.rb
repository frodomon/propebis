class Supplier < ActiveRecord::Base
  validates_presence_of :name, message: "Debe ingresar una Razón Social"
  validates :ruc, length: { is: 11, message: "Los números RUC tienen 11 digitos" }
  validates_presence_of :address, message: "Debe ingresar una dirección"
  validates :telephone, length: { in: 7..9, message: "Los números de telefono tienen entre 7 y 9 digitos"}
  validates_presence_of :contact, message: "Debe ingresar una persona de contacto"
  has_one :purchase_order
end
