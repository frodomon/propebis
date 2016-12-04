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