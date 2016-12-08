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
  $('#addendum_start_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
  $('#addendum_end_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
  $('#submit-form').submit(function(){
    date_flag = validate_start_end_date('#addendum_start_date','#addendum_end_date');
    fields = ['#addendum_addendum_number','#addendum_date','#addendum_start_date','#addendum_end_date','#addendum_ammount'];
    fields_flag = validate_form(fields);
    flag = date_flag && fields_flag;
    return flag;
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