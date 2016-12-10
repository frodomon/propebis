$(document).ready(function () {
  if($('form[id^="edit_"]').length > 0) {
    $('#remission_guide_date').datepicker({
      todayBtn: "linked",
      keyboardNavigation: false,
      forceParse: false,
      calendarWeeks: true,
      autoclose: true,
      todayHighlight: true,
      format: 'yyyy-mm-dd'
    });
    $('.sales_orders').show();
  };
  $('form').on('click', '.load_details', function(e){
    e.preventDefault();
    search = parseInt($('.sales_order_select').find(':selected').val());
    if (search != 0 ) {
      parameters = {search: search }; 
      load_details('/remission_guides/search_sales_order_details','content_details', parameters);
      fill_blanks();
      total = calculate_final_price('rgd_subtotal');
      $('#remission_guide_ammount').val(total);
    }
  });
  $('form').on('change', '#remission_guide_client_id',function(e){
    e.preventDefault();
    c_id = parseInt($(this).find(':selected').val()) - 1;
    delivery_address = clients[c_id].delivery_address;
    $('#remission_guide_final_point').val(delivery_address);
    $('#sales_orders_search').empty();
    c_id++;
    $('#sales_orders_search').append('<option value = "default" selected>Seleccione una Orden de Compra</option>');
    for(i=0; i < sales_orders.length; i++){
      if (c_id === sales_orders[i].client_id) {
        option = $('<option />');
        option.attr('value', sales_orders[i].id).text(sales_orders[i].sales_order_number);
        $('#sales_orders_search').append(option);
      }
    }
    $('.sales_orders').show();
  });
  $('form').on('change', '#remission_guide_business_id',function(e){
    e.preventDefault();
    business = $(this).find(':selected').val();
    b_id = parseInt(business) - 1;
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
    fields = ['#remission_guide_business_id','#remission_guide_client_id','#remission_guide_vehicle_id','#remission_guide_driver_id','#remission_guide_remission_guide_number','#remission_guide_initial_point','#remission_guide_final_point','#remission_guide_ammount'];
    fields_flag = validate_form(fields);
    return fields_flag;
  });
});