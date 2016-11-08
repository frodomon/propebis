$(document).on('turbolinks:load', function () {
  $('select[class="product_select"]').each(function(i){
    p_id = parseInt($(this).find(':selected').val()) - 1;
    if (p_id >= 0){
      pum= products[p_id].unit_of_measurement;
      $(this).next().val(pum);  
    }
  });
  $('form').on('click', '.load_details', function(e){
    e.preventDefault();
    search = parseInt($('.sales_order_select').find(':selected').val());
    if (search != 0 ) {
      parameters = {search: search }; 
      load_details('/remission_guides/search_sales_order_details','content_details', parameters);
      fill_blanks();
      total = calcular_precio_final();
    $('#remission_guide_ammount').val(total);
    }
  });
  $('form').on('change', '#remission_guide_client_id',function(e){
    e.preventDefault();
    client = $(this).find(':selected').val();
    c_id = parseInt(client) - 1;
    delivery_address = clients[c_id].delivery_address;
    $('#remission_guide_final_point').val(delivery_address);
  });
  $('form').on('change','.product_select',function(event){
    event.preventDefault();
    product_id = parseInt($(this).find(':selected').val()) -1;
    unit_of_measurement = products[product_id].unit_of_measurement;
    $(this).next().val(unit_of_measurement);
  });
  $('form').on('change','.rgd_unit_price',function(event){
    event.preventDefault();
    unit_price = parseFloat($(this).val());
    quantity = parseFloat($(this).prev().val());
    if (isNaN(quantity)) { quantity = 0;}
    subtotal = unit_price * quantity;
    $(this).next().val(subtotal);
    total = calcular_precio_final();
    $('#remission_guide_ammount').val(total);
  });
  $('form').on('change','.rgd_quantity',function(e){
    e.preventDefault();
    quantity = parseFloat($(this).val());
    unit_price = parseFloat($(this).next().val());
    if (isNaN(unit_price)) { unit_price = 0;}
    subtotal = unit_price * quantity;
    $(this).next().next().val(subtotal);
    total = calcular_precio_final();
    $('#remission_guide_ammount').val(total);
  });
  $('#remission_guide_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
});
function calcular_precio_final(){
  total = 0.0;
  $('input[class="rgd_subtotal"]').each(function(i){
    value = parseFloat($(this).val());
    total = total + value;
  });
  return total;
}
function fill_blanks(){
  $('select[class="product_select"]').each(function(i){
    p_id = parseInt($(this).find(':selected').val()) - 1;
    if (p_id >= 0){
      pum= products[p_id].unit_of_measurement;
      $(this).next().val(pum);  
    }
  });
}