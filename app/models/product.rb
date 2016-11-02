class Product < ActiveRecord::Base
  validates_presence_of :name, message: "Debe ingresar un nombre del producto"
  validates_presence_of :description, message: "Debe ingresar una descripción del producto"
  validates_presence_of :unit_of_measurement, message: "Debe ingresar la unidad de medida del producto"
  validates_presence_of :trademark, message: "Debe ingresar la marca del producto"
  validates_presence_of :category_id, message: "Debe elegir una categoría para el producto"
  belongs_to :category
  has_many :product_lots
  has_many :purchase_order_details
  has_many :contract_details
end
