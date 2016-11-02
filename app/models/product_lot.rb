class ProductLot < ActiveRecord::Base
  validates_presence_of :product_id, message: "Debe elegir un producto"
  validates_presence_of :quantity, message: "Debe ingresar la cantidad de producto del lote"
  validates_presence_of :lot_number, message: "Debe ingresar un número de lote del producto"
  belongs_to :product
  
  def self.search(search)
    if search
      joins(:product).where('products.id = ?',search)
    else
      all
    end
  end
  def self.search_by_date(search)
  	if search
  	  joins(:product).where('due_date <= ?',search)	
  	else
  	  all
  	end
  end
end
