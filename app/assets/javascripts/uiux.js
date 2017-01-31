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
function smart_checkbox_multiform(controller,field){
  if($('#submit-form[class^="edit_"]').length > 0) {
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
function load_table_controls(table_class_name, filename){
  variable = '.'+table_class_name;
  $(variable).DataTable({
    language: {
                "sProcessing":     "Procesando...",
                "sLengthMenu":     "Mostrar _MENU_ registros",
                "sZeroRecords":    "No se encontraron resultados",
                "sEmptyTable":     "Ningún dato disponible en esta tabla",
                "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
                "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
                "sInfoPostFix":    "",
                "sSearch":         "Buscar:",
                "sUrl":            "",
                "sInfoThousands":  ",",
                "sLoadingRecords": "Cargando...",
                "buttons":{
                  "copy": "Copiar",
                  "print": "Imprimir"
                },
                "oPaginate": {
                    "sFirst":    "Primero",
                    "sLast":     "Último",
                    "sNext":     "Siguiente",
                    "sPrevious": "Anterior"
                },
                
                "oAria": {
                    "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                    "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                }
              },
    pageLength: 25,
    responsive: true,
    dom: '<"html5buttons"B>lTfgitp',
    buttons: [
      { extend: 'copy'},
      {extend: 'csv'},
      {extend: 'excel', title: filename},
      {extend: 'pdf', title: filename},
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