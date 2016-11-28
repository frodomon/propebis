//= require jasny/jasny-bootstrap.min.js

$(document).ready(function () {
  if($('form[id^="edit_"]').length > 0) {
      $('.active').show();
    };
  $('select[class="product_select"]').each(function(i){
    p_id = parseInt($(this).find(':selected').val()) - 1;
    if (p_id >= 0){
      pum= products[p_id].unit_of_measurement;
      $(this).next().val(pum);  
    }
  });
  $('form').on('change','.product_select',function(event){
    event.preventDefault();
    product_id = parseInt($(this).find(':selected').val()) -1;
    unit_of_measurement = products[product_id].unit_of_measurement;
    $(this).next().val(unit_of_measurement);
  });  
  $('form').on('change','.contract_quantity',function(e){
    e.preventDefault();
    quantity = parseFloat($(this).val());
    unit_price = parseFloat($(this).next().val());
    if (isNaN(unit_price)) { unit_price = 0;}
    subtotal = unit_price * quantity;
    $(this).next().next().val(subtotal);
    total = calcular_precio_final();
    $('#contract_final_price').val(total).trigger('change');
  });
  $('form').on('change','.contract_unit_price',function(e){
    e.preventDefault();
    unit_price = parseFloat($(this).val());
    quantity = parseFloat($(this).prev().val());
    if (isNaN(quantity)) { quantity = 0;}
    subtotal = unit_price * quantity;
    $(this).next().val(subtotal);
    total = calcular_precio_final();
    $('#contract_final_price').val(total).trigger('change');
  });
  $('#contract_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
  $('#contract_start_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
  $('#contract_end_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
  
});
function calcular_precio_final(){
  total = 0.0;
  $('input[class="contract_subtotal"]').each(function(i){
    value = parseFloat($(this).val());
    total = total + value;
  });
  return total;
}
