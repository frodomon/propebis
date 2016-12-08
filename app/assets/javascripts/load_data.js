function load_partials(url, element_id, params){
  $.ajax({
      type: 'GET',
      url: url,
      async: false,
      data: params,
      success: function(data) {
        $('#'+element_id).html(data);
      },
      error : function() {
        alert('Error ocurred');
      }
    });
}
function load_details(url, element_id, params){
  $.ajax({
      type: 'GET',
      dataType: 'json',
      url: url,
      async: false,
      data: params,
      success: function(data) {
        $.each(data, function(i,object){
          if (i===0){
            fill_fields_from_json('#remission_guide_remission_guide_details_attributes_',i,object);
          }
          else{
            newNestedForm  = $('#content_details').last().clone()
            formsOnPage    = $('#content_details').length

            $(newNestedForm).find('select, input').each(function(){
              oldId = $(this).attr('id');
              newId = oldId.replace(new RegExp(/_[0-9]+_/), "_"+formsOnPage+"_");
              $(this).attr('id',newId);

              oldName = $(this).attr('name');
              newName = oldName.replace(new RegExp(/\[[0-9]+\]/), "["+formsOnPage+"]");
              $(this).attr('name',newName);

            });

            $(newNestedForm).appendTo('table').last();

            fill_fields_from_json('#remission_guide_remission_guide_details_attributes_',formsOnPage,object);
          }
        });
      },
      error : function(request, status, error) {
        alert(request.responseText);
      }
    });
}
function fill_fields_from_json(selector_str, id, object){
  $(selector_str+id+'_product_id option[value="'+object.product_id+'"]').prop('selected','selected').trigger('change');
  $(selector_str+id+'_quantity').val(object.quantity);
  $(selector_str+id+'_unit_price').val(object.unit_price);
  $(selector_str+id+'_subtotal').val(object.subtotal);
}