$(document).ready(function () {
  if($('form[id^="edit_"]').length > 0) {
    $('.contract').show();
  };
  $('form').on('change', '#sales_order_client_id',function(e){
    e.preventDefault();
    c_id = parseInt($(this).find(':selected').val());
    for(i=0; i < clients.length; i++){
      if (c_id = clients[i].id) {
        billing_address = clients[i].billing_address;
        delivery_address = clients[i].delivery_address;
        $('#sales_order_billing_address').val(billing_address);
        $('#sales_order_delivery_address').val(delivery_address);
      }
    }
    $('#sales_order_contract_id').empty()
    $('#sales_order_contract_id').append('<option value = "default" selected>Seleccione un Contrato</option>');
    for(i=0; i < contracts.length; i++){
      if (c_id = contracts[i].client_id) {
        option = $('<option />');
        option.attr('value', contracts[i].id).text(contracts[i].contract_number);
        $('#sales_order_contract_id').append(option);
      }
    }
    $('.contract').show(); 
  });
  $('form').on('change','.sod_unit_price',function(e){
    e.preventDefault();
    unit_price = parseFloat($(this).val());
    quantity = parseFloat($(this).closest('tr').find('.sod_quantity').val());
    if (isNaN(quantity)) { quantity = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.sod_subtotal').val(subtotal);
    total = calculate_final_price('sod_subtotal');
    $('#sales_order_ammount').val(total);
  });
  $('form').on('change','.sod_quantity',function(e){
    e.preventDefault();
    quantity = parseFloat($(this).val());
    unit_price = parseFloat($(this).closest('tr').find('.sod_unit_price').val());
    if (isNaN(unit_price)) { unit_price = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.sod_subtotal').val(subtotal);
    total = calculate_final_price('sod_subtotal');
    $('#sales_order_ammount').val(total)
  });
  $('#sales_order_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
  $('#sales_order_delivery_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
  $('#sales_order_order_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
  $('#submit-form').submit(function(){
    fields = ['#sales_order_business_id','#sales_order_contract_id','#sales_order_client_id','#sales_order_sales_order_number','#sales_order_date', '#sales_order_delivery_date','#sales_order_order_date','#sales_order_billing_address','#sales_order_delivery_address','#sales_order_ammount'];
    fields_flag = validate_form(fields);
    credit_flag = true;
    if ($('#sales_order_contract_id').find(':selected').val() !== ''){
      c_id = parseInt($('#sales_order_contract_id').find(':selected').val())-1;
      credit = contracts[c_id].credit;
      result = parseFloat($('#sales_order_ammount').val()) - credit
      if ( result > 0 ){
        alert('La orden de venta excede al credito del cliente en ' + result );
        credit_flag = false;
      }  
    }
    flag = fields_flag && credit_flag;
    return flag;
  });
});