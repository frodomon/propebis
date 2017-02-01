class StaticPagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to home_path
    else
      redirect_to new_user_session_path
    end
  end
  def home
    @settings = Setting.last
    expiration_date = Time.now + @settings.expiration_alert.days
    @alerts = ProductLot.search_by_date(expiration_date)
    @alertas =[]
    @alerts.each do |a|
      fecha = a.due_date.strftime("%d/%m/%Y")
      text = 'El lote ' + a.lot_number + ' del producto ' + Product.find(a.product_id).name + ' vence el ' + fecha
      @alertas << text
    end
  end
end
