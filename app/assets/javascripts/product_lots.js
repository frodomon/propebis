$(document).ready(function () {
  ultimo = $('table .content_details').last().addClass('new_row hidden_row').removeClass('content_details');
  $('#product_lot_due_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy/mm/dd'
  });
  $('#product_lot_production_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy/mm/dd'
  });
  $('#search_by_date').datepicker({
    todayBtn: "linked",
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true,
    todayHighlight: true,
    format: 'yyyy-mm-dd'
  });
  $('form').on('click','.search_button', function(e){
  	e.preventDefault();
  	search = $('#search').val();
  	if (search != 0 ) {
  	  parameters = {search: search }; 
  	  load_partials('/product_lots/search_lots_by_product','content', parameters);
      table = 'datatable';
      load_table_controls(table);
	  }
  });
  $('form').on('click','.search_by_date_button', function(e){
  	e.preventDefault();
  	search = $('#search_by_date').val();

  	if (search != 0 ) {
  	  parameters = {search: search }; 
	    load_partials('/product_lots/search_lots_close_to_expire','content', parameters); 
      table = 'datatable';
      load_table_controls(table);
	  }
  });
  $('form').on('click','.massive_load', function(e){
    e.preventDefault();
    search = $('#massive_load').val();
    $('#pod').val(search);
    if (search != 0 ) {
      parameters = {search: search }; 
      load_products('/product_lots/massive_load','table .content_details', parameters, '#lotes'); 
    }
  });
  $('form').on('click','.remove_rows', function(e){
    e.preventDefault();
    $(this).closest('tr').remove()
  });
  $('#content').on('click', '.add_rows', function(e){
    e.preventDefault();
    new_row  = $('table .new_row').clone().addClass('content_details').removeClass('hidden_row new_row');
    $('table .hidden_row').before(new_row);
  });
  $('#submit-massive-form').submit(function(){

    fields = ['#lotes__product_id','#lotes__quantity','#lotes__lot_number'];
    flag = true;
    for(i=0; i< fields.length; i++){
      $('table .content_details '+fields[i]).each(function(){
        if ($(this).val() === '' ){
          $(this).closest('td').addClass('has-error');
          flag = false;
        }
      });
    };
    return flag;
  });
});
function load_products(url, element_id, params, json_filler){
  $.ajax({
      type: 'GET',
      dataType: 'json',
      url: url,
      async: false,
      data: params,
      success: function(data) {
        $.each(data, function(i,object){
          if (i===0){
            fill_warehouse_from_json(element_id,json_filler,object);
          }
          else{
            new_row  = $('table .new_row').last().clone().addClass('content_details').removeClass('hidden_row new_row');
            $('table .content_details').last().after(new_row);
            fill_warehouse_from_json(element_id,json_filler,object);
          }
        });
      },
      error : function(request, status, error) {
        alert(request.responseText);
      }
    });
}
function fill_warehouse_from_json(row, selector_str, object){
  $(row+' '+selector_str+'__product_id option[value="'+object.product_id+'"]').last().prop('selected','selected').trigger('change');
  $(row+' '+selector_str+'__quantity').last().val(object.pending);
}
