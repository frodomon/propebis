$(document).ready(function () {
  if($('#submit-form[class^="edit_"]').length > 0) {
    $('#selection-buttons').hide();
    $('#form-content').show();
    if ($('#sales_order_contract_id').val() !== ''){
      $('.without').show();
      $('.contract').show();
    }
  };
  $('form').on('click', '#with',function(e){
    e.preventDefault();
    if ($(this).hasClass('active') === false ){
      $(this).addClass('active');
      if ($('#without').hasClass('active')){
        $('#without').removeClass('active');  
      }
    }
    $('#sales_order_client_id').empty();
    $('#sales_order_client_id').append('<option value = "default" selected>Seleccione un Cliente</option>');
    for(i=0; i < clients_with_contracts.length; i++){
      option = $('<option />');
      option.attr('value', clients_with_contracts[i].id).text(clients_with_contracts[i].name);
      $('#sales_order_client_id').append(option);
    }
    $('#form-content').show();
    $('.without').show();
    $('#content-form').val('1');
  });
  $('form').on('click', '#without',function(e){
    e.preventDefault();
    if ($(this).hasClass('active') === false ){
      $(this).addClass('active');
      if ($('#with').hasClass('active')){
        $('#with').removeClass('active');  
      }
    }
    $('#sales_order_client_id').empty();
    $('#sales_order_client_id').append('<option value = "default" selected>Seleccione un Cliente</option>');
    for(i=0; i < clients_without_contracts.length; i++){
      option = $('<option />');
      option.attr('value', clients_without_contracts[i].id).text(clients_without_contracts[i].name);
      $('#sales_order_client_id').append(option);
    }
    $('#form-content').show();
    $('#content-form').val('0');
  });
  $('form').on('change', '#select_status',function(e){
    status = parseInt($(this).find(':selected').val());
    $('#sales_order_status').val(status);
  });
  $('form').on('change', '#sales_order_client_id',function(e){
    e.preventDefault();
    c_id = parseInt($(this).find(':selected').val());
    for(i=0; i < clients.length; i++){
      if (c_id === clients[i].id) {
        billing_address = clients[i].billing_address;
        delivery_address = clients[i].delivery_address;
        $('#sales_order_billing_address').val(billing_address);
        $('#sales_order_delivery_address').val(delivery_address);
      }
    }
    $('#sales_order_contract_id').empty()
    $('#sales_order_contract_id').append('<option value = "default" selected>Seleccione un Contrato</option>');
    for(j=0; j < contracts.length; j++){
      if (c_id === contracts[j].client_id) {
        option = $('<option />');
        option.attr('value', contracts[j].id).text(contracts[j].contract_number);
        $('#sales_order_contract_id').append(option);
      }
    }
    $('.contract').show(); 
  });
  $('form').on('change', '#sales_order_contract_id',function(e){
    e.preventDefault();
    c_id = parseInt($(this).find(':selected').val());

    for(i=0; i < contracts.length; i++){
      if (c_id === contracts[i].id) {
        b_id = contracts[i].business_id;    
      }
    }
    $('#sales_order_business_id>option:eq('+b_id+')').prop('selected', true);
    $('#sales_order_business_id').attr('disabled', true);
    search = c_id
    if (search != 0 ) {
      parameters = {search: search }; 
      load_details('/sales_orders/search_contract_details','content_details', parameters,'#sales_order_sales_order_details_attributes_');
      fill_blanks();
      total = calculate_final_price('sod_subtotal');
      $('#sales_order_ammount').val(total);
    }
  });
  $('form').on('change','.sod_unit_price',function(e){
    e.preventDefault();
    unit_price = parseFloat($(this).val());
    quantity = parseFloat($(this).closest('tr').find('.sod_quantity').val());
    if (isNaN(quantity)) { quantity = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.sod_subtotal').val(subtotal);
    total = calculate_final_price('sod_subtotal');
    $('#sales_order_ammount').val(total);
  });
  $('form').on('change','.sod_quantity',function(e){
    e.preventDefault();
    quantity = parseFloat($(this).val());
    unit_price = parseFloat($(this).closest('tr').find('.sod_unit_price').val());
    if (isNaN(unit_price)) { unit_price = 0;}
    subtotal = unit_price * quantity;
    $(this).closest('tr').find('.sod_subtotal').val(subtotal);
    total = calculate_final_price('sod_subtotal');
    $('#sales_order_ammount').val(total)
  });
  $('#sales_order_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
  $('#sales_order_delivery_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
  $('#sales_order_order_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
  $('#submit-form').submit(function(){
    credit_flag = true;
    contract_flag = $('#content-form').val();
    $('#sales_order_business_id').attr('disabled', false);
    fields = ['#sales_order_business_id','#sales_order_client_id','#sales_order_sales_order_number','#sales_order_date', '#sales_order_delivery_date','#sales_order_order_date','#sales_order_billing_address','#sales_order_delivery_address','#sales_order_ammount'];
    if ( contract_flag === '1'){
      fields.push('#sales_order_contract_id'); 
    }
    fields_flag = validate_form(fields);
    if ( contract_flag === '1'){
      val_flag = $('#sales_order_contract_id').find(':selected').val() != ''
      if (val_flag){
        c_id = parseInt($('#sales_order_contract_id').find(':selected').val());
        for(i=0; i < contracts.length; i++){
          if (c_id === contracts[i].id) {
            credit = contracts[i].credit;
          }
        }
        result = credit - parseFloat($('#sales_order_ammount').val())
        if ( result < 0 ){
          alert('La orden de venta excede al credito del cliente en ' + result );
          credit_flag = false;
        }  
      }
    }
    flag = fields_flag && credit_flag;
    return flag;
  });
});