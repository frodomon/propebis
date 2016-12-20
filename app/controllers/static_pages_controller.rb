class StaticPagesController < ApplicationController
  skip_before_filter :require_login
  def home
  	@mainTitle = "Propebis"
    @mainDesc = "Kaihatsu labs"
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
  def login
  	render layout: 'empty'
  end
  def signup
  	render layout: 'empty'
  end
  def forgot_password
    render layout: 'empty'
  end
end
