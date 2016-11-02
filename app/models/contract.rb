class Contract < ActiveRecord::Base
  validates_presence_of :client_id, message: "Debe elegir un cliente"
  validates_presence_of :business_id, message: "Debe elegir una empresa"
  validates_presence_of :contract_number, message: "Debe ingresar el número del contrato"
  validates_presence_of :start_date, message: "Debe ingresar la fecha en la que empieza el contrato"
  validates_presence_of :end_date, message: "Debe ingresar la fecha em la que termina el contrato"
  validates_presence_of :final_price
  validates_presence_of :credit
  belongs_to :client
  belongs_to :business
  has_many :contract_details, dependent: :destroy
  has_many :contract_documents, dependent: :destroy
  has_many :addendums, dependent: :destroy
  accepts_nested_attributes_for :contract_details, allow_destroy: true
  accepts_nested_attributes_for :contract_documents, allow_destroy: true
  accepts_nested_attributes_for :addendums, allow_destroy: true
end
