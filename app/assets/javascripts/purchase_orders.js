$(document).ready(function () {
  if($('form[id^="edit_"]').length > 0) {
      $('.contract').show();
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
    $(this).next().val(unit_of_measurement);
  });
  $('form').on('change','.pod_unit_price',function(event){
    event.preventDefault();
    unit_price = parseFloat($(this).val());
    quantity = parseFloat($(this).prev().val());
    if (isNaN(quantity)) { quantity = 0;}
    subtotal = unit_price * quantity;
    $(this).next().val(subtotal);
    total = calcular_precio_final();
    $('#purchase_order_ammount').val(total);
  });
  $('form').on('change','.pod_quantity',function(e){
    e.preventDefault();
    quantity = parseFloat($(this).val());
    unit_price = parseFloat($(this).next().val());
    if (isNaN(unit_price)) { unit_price = 0;}
    subtotal = unit_price * quantity;
    $(this).next().next().val(subtotal);
    total = calcular_precio_final();
    $('#purchase_order_ammount').val(total);
  });
  $('#purchase_order_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
  $('#purchase_order_delivery_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
  $('#purchase_order_order_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
});
function fill_product_blank_fields(){
  $('.product_select').each(function(i){
    product = $(this).find(':selected').val();
    p_id = parseInt(product) - 1;
    if (p_id > 0){
      pum= products[p_id].unit_of_measurement;
    $(this).next.val(pum);  
    }
  });
}
function calcular_precio_final(){
  total = 0.0;
  $('input[class="pod_subtotal"]').each(function(i){
    value = parseFloat($(this).val());
    total = total + value;
  });
  return total;
}
