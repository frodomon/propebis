class Vehicle < ActiveRecord::Base
  validates_presence_of :plate, message: "Debe ingresar una placa"
  validates_presence_of :trademark, message: "Debe ingresar una marca del vehículo"
  validates_presence_of :capacity, message: "Debe ingresar la capacidad del vehículo"
end
