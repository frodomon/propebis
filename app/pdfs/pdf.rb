class Pdf < Prawn::Document
	def initialize(object, object_details, page_size)
    super(margin: [20,20], :page_size => page_size)
		font_size 10
		if object.is_a?(RemissionGuide)
			@rg = object
			@rgd = object_details
			rgd_content(page_size)
		end
		if object.is_a?(ControlGuide)
      @rg = object
      @rgd = object_details
      rgd_content(page_size)
		end
		if object.is_a?(Invoice)
      @inv = object
      @invd = object_details
      inv_content
		end
	end
  def inv_content
    @client = Client.find(@inv.client_id)
    so = SalesOrder.find(@inv.sales_order_id).sales_order_number
    move_down 80
    text_box "#{@client.name}", at: [60, cursor], :style => :bold
    text " "
    move_down 5
    text_box "#{@client.ruc}", at: [60, cursor], :style => :bold
    text " "
    move_down 5
    text_box "#{@client.billing_address }", at: [60, cursor], :style => :bold
    text " "
    move_down 25
    data = [[@inv.date, so]]
    table(data, position: :left, cell_style: {border_color: "FFFFFF", :font_style => :bold }, column_widths: [522,50])
    move_down 20
    inv_line_items    
  end
  def rgd_content(page_size)
  	@client = Client.find(@rg.client_id)
  	@vehicle = Vehicle.find(@rg.vehicle_id)
  	@driver = Driver.find(@rg.driver_id)
    a4 = page_size === 'A4'    
  	if a4
      move_down 86
    else
      move_down 56
    end
  	text_box "#{@rg.date.strftime("%d - %b - %Y") }", at: [80,cursor], :style => :bold
		text " "
		move_down 3
		text_box "#{@client.name}", at: [80, cursor], :style => :bold
		text " "
		move_down 3
		text_box "#{@client.ruc}", at: [80, cursor], :style => :bold
		text " "
		move_down 3
    text_box "#{@rg.initial_point }", at: [80, cursor], :style => :bold
    text " "
    move_down 3
    text_box "#{@rg.final_point }", at: [80, cursor], :style => :bold
    text " "
    move_down 15
    text_box "#{@vehicle.trademark} - #{@vehicle.plate}", at: [80, cursor], :style => :bold
    text " "
    move_down 14
    text_box "#{@driver.license}", at: [80, cursor], :style => :bold
    text " "
    move_down 35
		rg_line_items
    
  end
  def rg_line_items
    font_size 12
  	data = []
    @rgd.each do |od|
      p = Product.find(od.product_id)
    	data += [[od.quantity, p.unit_of_measurement, p.name]]
    end
    table(data, position: :left, cell_style: {border_color: "FFFFFF", :font_style => :bold }, column_widths: [50,50,240])  
	end
  def inv_line_items
    font_size 12
    data = []
    @invd.each do |id|
      p = Product.find(id.product_id)
      data += [[id.quantity, p.unit_of_measurement, p.name, id.unit_price, id.subtotal]]
    end
    table(data,position: :left, cell_style: {border_color: "FFFFFF", :font_style => :bold}, column_widths: [50,50,360,56,56])
  end
end