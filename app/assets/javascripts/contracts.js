$(document).ready(function () {
  if($('form[id^="edit_"]').length > 0) {
    $('.active').show();
    $('#contract_date').datepicker({
      todayBtn: "linked",
      keyboardNavigation: false,
      forceParse: false,
      calendarWeeks: true,
      autoclose: true,
      todayHighlight: true,
      format: 'yyyy-mm-dd'
    });
  };
  $('select[class="product_select select2_demo_1 form-control"]').each(function(i){
    p_id = parseInt($(this).find(':selected').val()) - 1;
    if (p_id >= 0){
      pum= products[p_id].unit_of_measurement;
      $(this).closest('tr').find('.unit_of_measurement').val(pum);
    }
  });
  $('form').on('change','.product_select',function(e){
    e.preventDefault();
    product_id = parseInt($(this).find(':selected').val()) -1;
    unit_of_measurement = products[product_id].unit_of_measurement;
    $(this).closest('tr').find('.unit_of_measurement').val(unit_of_measurement);
  });  
  $('form').on('change','.contract_quantity',function(e){
    e.preventDefault();
    quantity = parseFloat($(this).val());
    unit_price = parseFloat($(this).closest('tr').find('.contract_unit_price').val());
    if (isNaN(unit_price)) { unit_price = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.contract_subtotal').val(subtotal);
    total = calcular_precio_final();
    $('#contract_final_price').val(total).trigger('change');
  });
  $('form').on('change','.contract_unit_price',function(e){
    e.preventDefault();
    unit_price = parseFloat($(this).val());
    quantity = parseFloat($(this).closest('tr').find('.contract_quantity').val());
    if (isNaN(quantity)) { quantity = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.contract_subtotal').val(subtotal);
    total = calcular_precio_final();
    $('#contract_final_price').val(total).trigger('change');
  });
  
  $('#contract_start_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
  $('#contract_end_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
  
});
function calcular_precio_final(){
  total = 0.0;
  $('input[class="contract_subtotal form-control"]').each(function(i){
    value = parseFloat($(this).val());
    total = total + value;
  });
  return total;
}
