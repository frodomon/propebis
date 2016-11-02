class Vehicle < ActiveRecord::Base
  validates_presence_of :plate, message: "Debe ingresar una placa"
  validates_presence_of :trademark, message: "Debe ingresar una marca del vehículo"
end
