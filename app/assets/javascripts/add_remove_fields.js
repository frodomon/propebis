$(document).on('turbolinks:load', function () {
  $('form').on('click', '.add_fields', function(event){
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();
  });
  $('form').on('click','.remove_fields', function(event){
    $(this).prev().val('1');
    $(this).closest('div').hide();
    event.preventDefault();
  });
});
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
