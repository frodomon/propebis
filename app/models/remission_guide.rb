class RemissionGuide < ActiveRecord::Base
  validates_presence_of :business_id, message: "Debe elegir una empresa"
  validates_presence_of :client_id, message: "Debe elegir un cliente"
  validates_presence_of :driver_id, message: "Debe elegir un transportista"
  validates_presence_of :vehicle_id, message: "Debe elegir un vehículo"
  validates_presence_of :remission_guide_number, message: "Debe ingresar el número de guía de remisión"
  validates_presence_of :initial_point, message: "Debe ingresar el punto inicial"
  validates_presence_of :final_point, message: "Debe ingresar el punto final"
  validates_presence_of :date, message: "Debe ingresar la fecha de la guía de remisión"

  belongs_to :business
  belongs_to :client
  belongs_to :driver
  belongs_to :vehicle
  belongs_to :sales_order
  has_many :remission_guide_details, dependent: :destroy
  accepts_nested_attributes_for :remission_guide_details, allow_destroy: true

end
