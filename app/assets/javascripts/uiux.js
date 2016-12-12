function smart_checkbox(controller,field){
  if($('form[id^="edit_"]').length > 0) {
	active = $('#'+controller+'_'+field).val();
	if (active === 'false'){
	  $('#chk_'+field).iCheck('uncheck'); 
	}
	else{
	  $('#chk_'+field).iCheck('check'); 	
	}
  	$('#chk_'+field).on('ifChecked', function(e) {
  	  e.preventDefault();
  	  $('#'+controller+'_'+field).val('1');
  	});
  	$('#chk_'+field).on('ifUnchecked', function(e) {
  	  e.preventDefault();
  	  $('#'+controller+'_'+field).val('0');
  	});
  }
  else{
  	$('#chk_'+field).iCheck('disable')
  }
}
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