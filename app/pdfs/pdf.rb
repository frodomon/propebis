class Pdf < Prawn::Document
	def initialize(object, object_details, page_size, exonerado, guia)
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
      inv_content(exonerado, guia)
		end
	end
  def inv_content(exonerado, guia)
    @client = Client.find(@inv.client_id)
    so = SalesOrder.find(@inv.sales_order_id).sales_order_number
    gr = RemissionGuide.where('sales_order_id = ?',@inv.sales_order_id)
    move_down 71
    text_box "#{@client.name}", at: [60, cursor], :style => :bold
    text " "
    move_down 5
    text_box "#{@client.ruc}", at: [60, cursor], :style => :bold
    text " "
    move_down 5
    text_box "#{@client.billing_address }", at: [60, cursor], :style => :bold
    text " "
    move_down 25
    if guia === '1'
      data = [[@inv.date, gr[0].remission_guide_number, so]]
      puts 'numero de guias'+gr.length.to_s
      if gr.length > 1
        for i in 2..gr.length
          data += [[' ',gr[i-1].remission_guide_number,' ']]
        end
      end
      table(data, position: :left, cell_style: {:padding => [0,0,0,0], border_color: "FFFFFF", :font_style => :bold }, column_widths: [432, 90, 50])
    else
      data = [[@inv.date, so]]
      table(data, position: :left, cell_style: {:padding => [0,0,0,0], border_color: "FFFFFF", :font_style => :bold }, column_widths: [522, 50])
    end
    
    if gr.length > 1
      move_down 10
    else
      move_down 20
    end
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
      move_down 46
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
    table(data, position: :left, cell_style: {:padding => [0,0,0,0], border_color: "FFFFFF", :font_style => :bold }, column_widths: [50,50,240])  
	end
  def inv_line_items(exonerado)
    font_size 12
    data = []
    total = 0
    @invd.each do |id|
      p = Product.find(id.product_id)
      data += [[id.quantity, p.unit_of_measurement, p.name + " - " + p.trademark, id.unit_price, "%.2f" % id.subtotal]]
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
    decimal = total % 1 *100
    if decimal <10
      text_box "Son #{total.to_words} con 0#{decimal.to_i}/100 Soles", at: [0, 439], :style => :bold  
    else
      text_box "Son #{total.to_words} con #{decimal.to_i}/100 Soles", at: [0, 439], :style => :bold
    end
    line [512,427],[572,427]
    stroke
    text_box "Sub Total", at: [430,425], :style => :bold
    text_box "#{"%.2f" % subtotal.round(2)}", at: [512,425], :style => :bold, :align => :right
    text_box "IGV-18%", at: [430, 411], :style => :bold
    if igv === 0
      text_box '-', at: [542, 411], :style => :bold
    else
      text_box "#{"%.2f" % igv.round(2)}", at: [512,411], :style => :bold, :align => :right
    end
    line_width (2)
    line [512,400],[572,400]
    stroke
    text_box "Total S/.", at: [430, 397], :style => :bold
    text_box "#{"%.2f" % total.round(2)}", at: [512,397], :style => :bold, :align => :right

    line [200,413],[350,411] 
    stroke

    text_box "Cancelado:", at: [200,408] 
  end
end