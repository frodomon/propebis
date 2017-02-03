class Pdf < Prawn::Document
	def initialize(object, object_details)
		super(margin: [20,20], page_size: 'A4')
		font_size 8
		if object.is_a?(PurchaseOrder)
			@po = object
			@pod = object_details
			pod_content
		end
		if object.is_a?(RemissionGuide)
			@rg = object
			@rgd = object_details
			rgd_content
		end
		if object.is_a?(ControlGuide)
		end
		if object.is_a?(Invoice)
		end
	end
	def pod_content
		@supplier = Supplier.find(@po.supplier_id)

		text "#{@supplier.name}"
    text "#{@supplier.ruc}"
    text "#{@po.billing_address }"
    text "#{@po.date.strftime("%d/%m/%Y") }"
    text "#{@po.delivery_address }"
    line_items
  end
  def rgd_content
  	@client = Client.find(@rg.client_id)
  	@vehicle = Vehicle.find(@rg.vehicle_id)
  	@driver = Driver.find(@rg.driver_id)
  	move_down 66
  	text_box "#{@rg.date.strftime("%d - %b - %Y") }", at: [70,cursor]
		text " "
		move_down 3
		text_box "#{@client.name}", at: [70, cursor]
		text " "
		move_down 3
		text_box "#{@client.ruc}", at: [70, cursor]
		text " "
		move_down 4
    text_box "#{@rg.initial_point }", at: [70, cursor]
    text " "
    move_down 4
    text_box "#{@rg.final_point }", at: [70, cursor]
    text " "
    move_down 25
    text_box "#{@vehicle.trademark} - #{@vehicle.plate}", at: [70, cursor]
    text " "
    move_down 14
    text_box "#{@driver.license}", at: [70, cursor]
    text " "
    move_down 30
		rg_line_items
    
  end
  def rg_line_items
  	data = []
    @rgd.each do |od|
      p = Product.find(od.product_id)
    	data += [[od.quantity, p.unit_of_measurement, p.name]]
    end
    table(data, header: true, position: :left, cell_style: {border_color: "FFFFFF"}, column_widths: [50,30,200])
	end

end