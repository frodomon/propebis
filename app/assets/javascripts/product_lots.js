$(document).ready(function () {
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

function load_table_controls(table_class_name){
  variable = '.'+table_class_name;
  $('.'+table_class_name).DataTable({
    pageLength: 25,
    responsive: true,
    dom: '<"html5buttons"B>lTfgitp',
    buttons: [
      { extend: 'copy'},
      {extend: 'csv'},
      {extend: 'excel', title: 'ExampleFile'},
      {extend: 'pdf', title: 'ExampleFile'},
      {extend: 'print',
        customize: function (win){
          $(win.document.body).addClass('white-bg');
          $(win.document.body).css('font-size', '10px');
          $(win.document.body).find('table')
            .addClass('compact')
            .css('font-size', 'inherit');
        }
      }
    ]
  });
};