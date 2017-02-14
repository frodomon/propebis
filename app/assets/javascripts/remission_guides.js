$(document).ready(function () {
  if($('#submit-form[class^="edit_"]').length > 0) {
    $('.sales_orders').show();
    $('.load_details').hide();
  };

  $('form').on('click', '.load_details', function(e){
    e.preventDefault();
    search = parseInt($('.sales_order_select').find(':selected').val());
    if (search != 0 ) {
      parameters = {search: search }; 
      load_details('/remission_guides/search_sales_order_details','content_details', parameters, '#remission_guide_remission_guide_details_attributes_', 'guia_de_remision');
      fill_blanks();
      total = calculate_final_price('rgd_subtotal');
      $('#remission_guide_ammount').val(total);
      $('.load_details').hide();
      qty = $('table #content_details').length
      if (qty > 20){
        alert('Hay demasiados items en la factura. Se imprimirá en 2 hojas')  
      }
    }
  });
  $('form').on('change', '#remission_guide_client_id',function(e){
    e.preventDefault();
    c_id = parseInt($(this).find(':selected').val());
    for(i=0; i < clients.length; i++){
      if (c_id == clients[i].id) {
        delivery_address = clients[i].delivery_address;
        $('#remission_guide_final_point').val(delivery_address);
      }
    }
    $('#remission_guide_sales_order_id').empty();
    $('#remission_guide_sales_order_id').append('<option value = "default" selected>Seleccione una Orden de Compra</option>');
    for(i=0; i < sales_orders.length; i++){
      if (c_id === sales_orders[i].client_id) {
        option = $('<option />');
        option.attr('value', sales_orders[i].id).text(sales_orders[i].sales_order_number);
        $('#remission_guide_sales_order_id').append(option);
      }
    }
    $('.sales_orders').show();
  });
  $('form').on('change', '#remission_guide_sales_order_id',function(e){
    e.preventDefault();
    sod_id = parseInt($(this).find(':selected').val());
    for(i=0; i < sales_orders.length; i++){
      if (sod_id === sales_orders[i].id){
        b_id = sales_orders[i].business_id
        for(j=0; j < businesses.length; j++){
          if (b_id === businesses[j].id){
            $('#remission_guide_business_id>option:eq('+b_id+')').prop('selected', true).trigger('change');
          }
        }
      }
    }
    $('#remission_guide_business_id').attr('disabled', true);
  });
  $('form').on('change', '#remission_guide_business_id',function(e){
    e.preventDefault();
    b_id = parseInt($(this).find(':selected').val()) - 1;
    delivery_address = businesses[b_id].delivery_address;
    $('#remission_guide_initial_point').val(delivery_address);
  });
  $('form').on('change','.rgd_unit_price',function(event){
    event.preventDefault();
    unit_price = parseFloat($(this).val());
    quantity = parseFloat($(this).closest('tr').find('.rgd_quantity').val());
    if (isNaN(quantity)) { quantity = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.rgd_subtotal').val(subtotal);
    total = calculate_final_price('rgd_subtotal');
    $('#remission_guide_ammount').val(total);
  });
  $('form').on('change','.rgd_quantity',function(e){
    e.preventDefault();
    quantity = parseFloat($(this).val());
    unit_price = parseFloat($(this).closest('tr').find('.rgd_unit_price').val());
    if (isNaN(unit_price)) { unit_price = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.rgd_subtotal').val(subtotal);
    total = calculate_final_price('rgd_subtotal');
    $('#remission_guide_ammount').val(total);
  });
  $('#submit-form').submit(function(){
    total = calculate_final_price('rgd_subtotal');
    $('#remission_guide_ammount').val(total);
    $('#remission_guide_business_id').attr('disabled', false);
    fields = ['#remission_guide_business_id','#remission_guide_client_id','#remission_guide_vehicle_id','#remission_guide_driver_id','#remission_guide_remission_guide_number','#remission_guide_initial_point','#remission_guide_final_point','#remission_guide_ammount'];
    fields_flag = validate_form(fields);
    return fields_flag;
  });
  $('#remission_guide_date').datepicker({
      todayBtn: "linked",
      keyboardNavigation: false,
      forceParse: false,
      calendarWeeks: true,
      autoclose: true,
      todayHighlight: true,
      format: 'yyyy-mm-dd'
    });
});