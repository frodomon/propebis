$(document).ready(function () {
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
});