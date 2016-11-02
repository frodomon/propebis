class Category < ActiveRecord::Base
	validates_presence_of :name, message: "Debe ingresar un Nombre"
	has_one :product
end
