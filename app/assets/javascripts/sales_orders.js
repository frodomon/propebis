$(document).on('turbolinks:load', function () {
  $('select[class="product_select"]').each(function(i){
    p_id = parseInt($(this).find(':selected').val()) - 1;
    if (p_id >= 0){
      pum= products[p_id].unit_of_measurement;
      $(this).next().val(pum);  
    }
  });
  $('form').on('change', '#sales_order_client_id',function(e){
    e.preventDefault();
    client = $(this).find(':selected').val();
    c_id = parseInt(client);
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
  $('form').on('change','.product_select',function(event){
    event.preventDefault();
    product_id = parseInt($(this).find(':selected').val()) -1;
    unit_of_measurement = products[product_id].unit_of_measurement;
    $(this).next().val(unit_of_measurement);
  });
  $('form').on('change','.sod_unit_price',function(e){
    e.preventDefault();
    unit_price = parseFloat($(this).val());
    quantity = parseFloat($(this).prev().val());
    if (isNaN(quantity)) { quantity = 0;}
    subtotal = unit_price * quantity;
    $(this).next().val(subtotal);
    total = calcular_precio_final();
    $('#sales_order_ammount').val(total);
  });
  $('form').on('change','.sod_quantity',function(e){
    e.preventDefault();
    quantity = parseFloat($(this).val());
    unit_price = parseFloat($(this).next().val());
    if (isNaN(unit_price)) { unit_price = 0;}
    subtotal = unit_price * quantity;
    $(this).next().next().val(subtotal);
    total = calcular_precio_final();
    $('#sales_order_ammount').val(total)
  });
  $('#sales_order_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
  $('#sales_order_delivery_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
  $('#sales_order_order_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
});
function calcular_precio_final(){
  total = 0.0;
  $('input[class="sod_subtotal"]').each(function(i){
    value = parseFloat($(this).val());
    total = total + value;
  });
  return total;
}