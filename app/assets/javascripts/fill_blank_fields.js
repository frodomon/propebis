$(document).ready(function () {
  $('select[class="product_select select2_demo_1 form-control"]').each(function(i){
    p_id = parseInt($(this).find(':selected').val());
    pum = ''
    for(i=0;i < products.length;i++){
      if (products[i].id == p_id){
        pum = products[i].unit_of_measurement;
      }  
    }
    $(this).closest('tr').find('.unit_of_measurement').val(pum);
  });
   $('form').on('change','.product_select',function(event){
    event.preventDefault();
    p_id = parseInt($(this).find(':selected').val());
    for(i=0;i < products.length;i++){
      if (products[i].id == p_id){
        unit_of_measurement = products[i].unit_of_measurement;
      }  
    }
    $(this).closest('tr').find('.unit_of_measurement').val(unit_of_measurement);
  });
});
function fill_blanks(){
  $('select[class="product_select"]').each(function(i){
    p_id = parseInt($(this).find(':selected').val());
    for(i=0;i < products.length;i++){
      if (products[i].id == p_id){
        pum= products[i].unit_of_measurement;
      }  
    }
    $(this).next().val(pum);  
  });
}
function calculate_final_price(subtotal_field){
  total = 0.0;
  $('input[class="'+subtotal_field+' form-control"]').each(function(i){
    value = parseFloat($(this).val());
    total = total + value;
  });
  return total;
}