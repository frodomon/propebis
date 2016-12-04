$(document).ready(function () {
  mostrar_numero_contrato(); 
  $('form').on('change','.addendum_quantity',function(e){
    e.preventDefault();
    quantity = parseFloat($(this).val());
    unit_price = parseFloat($(this).closest('tr').find('.addendum_unit_price').val());
    if (isNaN(unit_price)) { unit_price = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.addendum_subtotal').val(subtotal);
    total = calcular_monto_adenda();
    $('#addendum_ammount').val(total);
  });
  $('form').on('change','.addendum_unit_price',function(e){
    e.preventDefault();
    unit_price = parseFloat($(this).val());
    quantity = parseFloat($(this).closest('tr').find('.addendum_quantity').val());
    if (isNaN(quantity)) { quantity = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.addendum_subtotal').val(subtotal);
    total = calcular_monto_adenda();
    $('#addendum_ammount').val(total);
  });
  $('#addendum_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
});
function calcular_monto_adenda(){
  total = 0.0;
  $('input[class="addendum_subtotal form-control"]').each(function(i){
    value = parseFloat($(this).val());
    total = total + value;
  });
  return total;
}
function mostrar_numero_contrato(){
  contract = contract.contract_number;
  $('.contract_number').val(contract);
}