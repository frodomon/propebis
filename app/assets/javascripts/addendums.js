$(document).on('turbolinks:load', function () {
  mostrar_numero_contrato();
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
  $('form').on('change','.addendum_quantity',function(e){
    e.preventDefault();
    quantity = parseFloat($(this).val());
    unit_price = parseFloat($(this).next().val());
    if (isNaN(unit_price)) { unit_price = 0;}
    subtotal = unit_price * quantity;
    $(this).next().next().val(subtotal);
    total = calcular_monto_adenda();
    $('#addendum_ammount').val(total);
  });
  $('form').on('change','.addendum_unit_price',function(e){
    e.preventDefault();
    unit_price = parseFloat($(this).val());
    quantity = parseFloat($(this).prev().val());
    if (isNaN(quantity)) { quantity = 0;}
    subtotal = unit_price * quantity;
    $(this).next().val(subtotal);
    total = calcular_monto_adenda();
    $('#addendum_ammount').val(total);
  });
  $('.addendum_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
});
function calcular_monto_adenda(){
  total = 0.0;
  $('input[class="addendum_subtotal"]').each(function(i){
    value = parseFloat($(this).val());
    total = total + value;
  });
  return total;
}
function mostrar_numero_contrato(){
  contract = contract.contract_number;
  $('.contract_number').val(contract);
}