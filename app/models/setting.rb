class Setting < ApplicationRecord
  validates_presence_of :expiration_alert, message: "Debe ingresar los dias para mostrar la alerta"
end
