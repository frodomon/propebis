$(document).ready(function () {
  if($('#submit-form[class^="edit_"]').length > 0) {
    $('.sales_orders').show();
    $('.load_details').hide();
  };
  $('#invoice_date').datepicker({
      todayBtn: "linked",
      keyboardNavigation: false,
      forceParse: false,
      calendarWeeks: true,
      autoclose: true,
      todayHighlight: true,
      format: 'yyyy-mm-dd'
    });

  $('form').on('click', '.load_details', function(e){
    e.preventDefault();
    search = parseInt($('.sales_order_select').find(':selected').val());
    if (search != 0 ) {
      parameters = {search: search }; 
      load_details('/invoices/search_sales_order_details','content_details', parameters, '#invoice_invoice_details_attributes_');
      fill_blanks();
      total = calculate_final_price('inv_subtotal');
      $('#invoice_ammount').val(total);
    }
  });
  $('form').on('change', '#invoice_client_id',function(e){
    e.preventDefault();
    c_id = parseInt($(this).find(':selected').val());
    $('#invoice_sales_order_id').empty();
    $('#invoice_sales_order_id').append('<option value = "default" selected>Seleccione una Orden de Compra</option>');
    for(i=0; i < sales_orders.length; i++){
      if (c_id === sales_orders[i].client_id) {
        option = $('<option />');
        option.attr('value', sales_orders[i].id).text(sales_orders[i].sales_order_number);
        $('#invoice_sales_order_id').append(option);
      }
    }
    $('.sales_orders').show();
  });
  $('form').on('change', '#invoice_sales_order_id',function(e){
    e.preventDefault();
    sod_id = parseInt($(this).find(':selected').val());
    for(i=0; i < sales_orders.length; i++){
      if (sod_id === sales_orders[i].id){
        b_id = sales_orders[i].business_id
        for(j=0; j < businesses.length; j++){
          if (b_id === businesses[j].id){
            $('#invoice_business_id>option:eq('+b_id+')').prop('selected', true).trigger('change');
          }
        }
      }
    }
    $('#invoice_business_id').attr('disabled', true);
    $('.load_details').hide();
  });
  $('form').on('change','.inv_unit_price',function(event){
    event.preventDefault();
    unit_price = parseFloat($(this).val());
    quantity = parseFloat($(this).closest('tr').find('.inv_quantity').val());
    if (isNaN(quantity)) { quantity = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.inv_subtotal').val(subtotal);
    total = calculate_final_price('inv_subtotal');
    $('#invoice_ammount').val(total);
  });
  $('form').on('change','.inv_quantity',function(e){
    e.preventDefault();
    quantity = parseFloat($(this).val());
    unit_price = parseFloat($(this).closest('tr').find('.inv_unit_price').val());
    if (isNaN(unit_price)) { unit_price = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.inv_subtotal').val(subtotal);
    total = calculate_final_price('inv_subtotal');
    $('#invoice_ammount').val(total);
  });
  $('#submit-form').submit(function(){
    $('#invoice_business_id').attr('disabled', false);
    fields = ['#invoice_business_id','#invoice_client_id','#invoice_invoice_number','#invoice_date','#invoice_ammount'];
    fields_flag = validate_form(fields);
    return fields_flag;
  });
});