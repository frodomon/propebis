$(document).on('turbolinks:load', function () {
  $('#product_lot_due_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
  $('#product_lot_production_date').datepicker({
    dateFormat: 'dd-mm-yy'
  });
  $('#search_by_date').datepicker({
    dateFormat: 'yy-mm-dd'
  });
  $('form').on('click','.search_button', function(e){
  	e.preventDefault();
  	search = $('#search').val();
  	if (search != 0 ) {
  	  parameters = {search: search }; 
  	  load_partials('/product_lots/search_lots_by_product','content', parameters);
	}
  });
  $('form').on('click','.search_by_date_button', function(e){
  	e.preventDefault();
  	search = $('#search_by_date').val();
  	if (search != 0 ) {
  	  parameters = {search: search }; 
	  load_partials('/product_lots/search_lots_close_to_expire','content', parameters);
	}
  });
});
