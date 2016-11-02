$(document).on('turbolinks:load', function () {
  $('select[class="product_select"]').each(function(i){
    p_id = parseInt($(this).find(':selected').val()) - 1;
    if (p_id >= 0){
      pum= products[p_id].unit_of_measurement;
      $(this).next().val(pum);  
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
  $('#remission_guide_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
});