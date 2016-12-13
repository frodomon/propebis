class Driver < ActiveRecord::Base
  validates_presence_of :name, message: "Debe ingresar un Nombre"
  validates_presence_of :license, message: "Debe ingresar un número de licencia de conducir"

  has_many :remission_guides
  has_many :control_guides
end
