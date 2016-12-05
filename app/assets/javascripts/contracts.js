$(document).ready(function () {
  smart_checkbox('contract','active');
  if($('form[id^="edit_"]').length > 0) {
    $('#contract_date').datepicker({
      todayBtn: "linked",
      keyboardNavigation: false,
      forceParse: false,
      calendarWeeks: true,
      autoclose: true,
      todayHighlight: true,
      format: 'yyyy-mm-dd'
    });
  };
  $('form').on('change','.contract_quantity',function(e){
    e.preventDefault();
    quantity = parseFloat($(this).val());
    unit_price = parseFloat($(this).closest('tr').find('.contract_unit_price').val());
    if (isNaN(unit_price)) { unit_price = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.contract_subtotal').val(subtotal);
    total = calculate_final_price('contract_subtotal');
    $('#contract_final_price').val(total).trigger('change');
  });
  $('form').on('change','.contract_unit_price',function(e){
    e.preventDefault();
    unit_price = parseFloat($(this).val());
    quantity = parseFloat($(this).closest('tr').find('.contract_quantity').val());
    if (isNaN(quantity)) { quantity = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.contract_subtotal').val(subtotal);
    total = calculate_final_price('contract_subtotal');
    $('#contract_final_price').val(total).trigger('change');
  });
  
  $('#contract_start_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
  $('#contract_end_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
});