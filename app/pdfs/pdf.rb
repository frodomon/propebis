class Pdf < Prawn::Document
	def initialize(object, object_details, page_size, exonerado)
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
      inv_content(exonerado)
		end
	end
  def inv_content(exonerado)
    @client = Client.find(@inv.client_id)
    so = SalesOrder.find(@inv.sales_order_id).sales_order_number
    move_down 75
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
    inv_line_items(exonerado)   
  end
  def rgd_content(page_size)
  	@client = Client.find(@rg.client_id)
  	@vehicle = Vehicle.find(@rg.vehicle_id)
  	@driver = Driver.find(@rg.driver_id)
    a4 = page_size === 'A4'    
  	if a4
      move_down 66
    else
      move_down 48
    end
  	text_box "#{@rg.date.strftime("%d - %b - %Y") }", at: [80,cursor], :style => :bold
		text " "
		move_down 2
		text_box "#{@client.name}", at: [80, cursor], :style => :bold
		text " "
		move_down 2
		text_box "#{@client.ruc}", at: [80, cursor], :style => :bold
		text " "
		move_down 2
    text_box "#{@rg.initial_point }", at: [80, cursor], :style => :bold
    text " "
    move_down 2
    text_box "#{@rg.final_point }", at: [80, cursor], :style => :bold
    text " "
    if a4
      move_down 25
    else
      move_down 24
    end
    text_box "#{@vehicle.trademark} - #{@vehicle.plate}", at: [80, cursor], :style => :bold
    text " "
    move_down 14
    text_box "#{@driver.license}", at: [80, cursor], :style => :bold
    text " "
    move_down 20
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
  def inv_line_items(exonerado)
    font_size 12
    data = []
    total = 0
    @invd.each do |id|
      p = Product.find(id.product_id)
      data += [[id.quantity, p.unit_of_measurement, p.name, id.unit_price, "%.2f" % id.subtotal]]
      total += id.subtotal
    end
    table data, :position => :left, 
      :cell_style => {
        :padding => [0,0,0,0],
        :border_color => "FFFFFF", 
        :font_style => :bold
      },
      column_widths: [50,50,360,56,56] do |t|
        t.column(4).style(:align => :right)
    end

    if exonerado === '1'
      move_down 6
      data2 = [[ 'EXONERADO DE IGV' ]]
      table data2, :position => :center, :cell_style => { :padding => [5,30,5,30], :font_style => :bold}
      subtotal = total
      igv = 0
    else
      subtotal = total/1.18
      igv = subtotal*0.18
    end
    puts 'igv = ' + igv.to_s
    decimal = total % 1 *100
    if decimal <10
      text_box "Son #{total.to_words} con 0#{decimal.to_i}/100 Soles", at: [0, 499], :style => :bold  
    else
      text_box "Son #{total.to_words} con #{decimal.to_i}/100 Soles", at: [0, 499], :style => :bold
    end
    line [512,487],[572,487]
    stroke
    text_box "Sub Total", at: [430,485], :style => :bold
    text_box "#{"%.2f" % subtotal.round(2)}", at: [512,485], :style => :bold, :align => :right
    text_box "IGV-18%", at: [430, 471], :style => :bold
    if igv === 0
      text_box '-', at: [542, 471], :style => :bold
    else
      text_box "#{"%.2f" % igv.round(2)}", at: [512,471], :style => :bold, :align => :right
    end
    line_width (2)
    line [512,457],[572,457]
    stroke
    text_box "Total S/.", at: [430, 454], :style => :bold
    text_box "#{"%.2f" % total.round(2)}", at: [512,454], :style => :bold, :align => :right

    line [200,459],[350,459] 
    stroke

    text_box "Cancelado:", at: [200,457] 
  end
end