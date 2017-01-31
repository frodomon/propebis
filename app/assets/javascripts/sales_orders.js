$(document).ready(function () {
  if($('#submit-form[class^="edit_"]').length > 0) {
    $('#selection-buttons').hide();
    $('#form-content').show();
    if (id !== 0){  
      $('.without').show();
      $('.contract').show();
    }
    else{
      $('#sales_order_contract_id').val(id);
    }
    select_val = $('#sales_order_status').val();
    $('#select_status option:eq('+select_val+')').attr('selected', 'selected')  
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
    $('#content_details .sod_unit_price').attr('readonly', false);
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
    flag_sales_order = false;
    o_venta = [];
    contract_flag = $('#content-form').val() === '1';
    val_flag = $('#sales_order_contract_id').find(':selected').val() != ''
    c_id = parseInt($('#sales_order_contract_id').find(':selected').val());

    $('#sales_order_business_id').attr('disabled', false);
    $('#sales_order_status').attr('disabled', true);
    fields = ['#sales_order_siaf_number','#sales_order_business_id','#sales_order_client_id','#sales_order_sales_order_number','#sales_order_date', '#sales_order_delivery_date','#sales_order_order_date','#sales_order_billing_address','#sales_order_delivery_address','#sales_order_ammount'];
    if ( contract_flag){
      fields.push('#sales_order_contract_id'); 
    }
    fields_flag = validate_form(fields);
    if (contract_flag){
      if (val_flag){
        for(i=0; i < contracts.length; i++){
          if (c_id === contracts[i].id) {
            credit = contracts[i].credit;
          }
        }
        for(j=0; j < sales_orders.length; j++){
          if (c_id === sales_orders[j].contract_id){
            if (sales_orders[j].status === 0 || sales_orders[j].status === 2) {
              o_venta.push(sales_orders[j])
            }
          }
        }
        monto_ventas = 0
        if (o_venta.length > 0){
          flag_sales_order = true;
          for(k=0;k<o_venta.length;k++){
            monto_ventas = monto_ventas + o_venta[k].ammount;
          }
        }
        ordenes = o_venta.length;
        monto = parseFloat($('#sales_order_ammount').val());
        result = credit - (monto + monto_ventas)
        if ( result < 0 ){
          result = Math.abs(result);
          if (flag_sales_order){
            if (ordenes < 2){
              alert('La orden de venta excede al crédito del cliente en S/. ' + result + '.\nAdemás hay ' + ordenes + ' orden de venta por despachar.'); 
            }
            else{
              alert('La orden de venta excede al crédito del cliente en S/. ' + result + '.\nAdemás Hay ' + ordenes + ' ordenes de venta por despachar.' );  
            }
          }
          else{
            alert('La orden de venta excede al crédito del cliente en S/. ' + result );  
          }
          credit_flag = false; 
        }
      }
    }//fin de verificacion con contrato
    warehouse_flag = true;
    sod_products= []
    product_errors = []
    $('.product_select').each(function(i){
      p_id = parseInt($(this).find(':selected').val());
      p_name = $(this).find(':selected').text();
      p_qty = parseFloat($(this).closest('tr').find('.sod_quantity').val());
      p_um = $(this).closest('tr').find('.unit_of_measurement').val();
      item = [p_id, p_qty, p_name, p_um];
      sod_products.push(item);
    });
    if (sod_products.length > 0){
      for(l=0;l<sod_products.length;l++){
        available = verify_warehouse(sod_products[l][0],sod_products[l][1])
        if (available < 0){
          missing = Math.abs(available)
          error = 'Faltan ' + missing + ' ' + sod_products[l][3] +' de '+ sod_products[l][2] + ' en el almacén para poder hacer la orden de venta.'
          product_errors.push(error);
          warehouse_flag = false
        }
      }  
    }
    if (product_errors.length > 0){
      string_errors = ""
      for(m=0;m<product_errors.length;m++){
        string_errors = string_errors.concat(product_errors[m],"\n");
      }
      alert(string_errors)
    }
    flag = fields_flag && credit_flag && warehouse_flag;
    return flag;
  });
});
function verify_warehouse(p_id, quantity){
  parameters = {p_id: p_id }; 
  stock = get_data('/sales_orders/search_stock_for_product', parameters);
  result = stock.quantity - quantity;
  return result;
} 