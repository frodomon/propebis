//= require jasny/jasny-bootstrap.min.js

$(document).ready(function () {
  if($('form[id^="edit_"]').length > 0) {
    $('.contract').show();
    $('#purchase_order_date').datepicker({
      todayBtn: "linked",
      keyboardNavigation: false,
      forceParse: false,
      calendarWeeks: true,
      autoclose: true,
      format: 'yyyy-mm-dd'
    });
  };
  $('select[class="product_select"]').each(function(i){
    p_id = parseInt($(this).find(':selected').val()) - 1;
    if (p_id >= 0){
      pum= products[p_id].unit_of_measurement;
      $(this).next().val(pum);  
    }
  });
  $('form').on('change', '#purchase_order_business_id',function(e){
    e.preventDefault();
    business = $(this).find(':selected').val();
    b_id = parseInt(business) - 1;
    billing_address = businesses[b_id].billing_address;
    delivery_address = businesses[b_id].delivery_address;
    $('#purchase_order_billing_address').val(billing_address);
    $('#purchase_order_delivery_address').val(delivery_address);
  });
  $('form').on('change','.product_select',function(event){
    event.preventDefault();
    product_id = parseInt($(this).find(':selected').val()) -1;
    unit_of_measurement = products[product_id].unit_of_measurement;
    $(this).closest('tr').find('.unit_of_measurement').val(unit_of_measurement);
  });
  $('form').on('change','.pod_unit_price',function(event){
    event.preventDefault();
    unit_price = parseFloat($(this).val());
    quantity = parseFloat($(this).closest('tr').find('.pod_quantity').val());
    if (isNaN(quantity)) { quantity = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.pod_subtotal').val(subtotal);
    total = calcular_precio_final();
    alert(total);
    $('#purchase_order_ammount').val(total);
  });
  $('form').on('change','.pod_quantity',function(e){
    e.preventDefault();
    quantity = parseFloat($(this).val());
    unit_price = parseFloat($(this).closest('tr').find('.pod_unit_price').val());
    if (isNaN(unit_price)) { unit_price = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.pod_subtotal').val(subtotal);
    total = calcular_precio_final();
    alert(total);
    $('#purchase_order_ammount').val(total);
  });
  
  $('#purchase_order_delivery_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    format: 'yyyy-mm-dd'
  });
  $('#purchase_order_order_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    format: 'yyyy-mm-dd'
  });
});
function fill_product_blank_fields(){
  $('.product_select').each(function(i){
    product = $(this).find(':selected').val();
    p_id = parseInt(product) - 1;
    if (p_id > 0){
      pum= products[p_id].unit_of_measurement;
    $(this).closest('tr').find('.unit_of_measurement').val(pum);  
    }
  });
}
function calcular_precio_final(){
  total = 0.0;
  $('input[class="pod_subtotal form-control"]').each(function(i){
    value = parseFloat($(this).val());
    total = total + value;
  });
  return total;
}
