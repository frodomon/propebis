class Addendum < ActiveRecord::Base
  validates_presence_of :contract_id, message: "Debe ingresar un contrato"
  validates_presence_of :addendum_number, message: "Debe ingresar el número de adenda"
  validates_presence_of :date, message: "Debe ingresar la fecha en que se hizo la adenda"
  validates_presence_of :start_date, message: "Debe ingresar la fecha de inicio de la adenda"
  validates_presence_of :ammount, message: "Debe ingresar el monto de la adenda"
  belongs_to :contract
  has_many :addendum_documents, dependent: :destroy
  has_many :addendum_details, dependent: :destroy
  accepts_nested_attributes_for :addendum_documents, allow_destroy: true
  accepts_nested_attributes_for :addendum_details, allow_destroy: true
end
