$(document).ready(function () {
  $('form').on('click','.add_fields', function(e){
    e.preventDefault();
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
  });
  $('form').on('click', '.add_row_fields', function(event){
    event.preventDefault();
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('table tr:last').after($(this).data('fields').replace(regexp, time));
  });
  $('form').on('click','.remove_fields', function(e){
    e.preventDefault();
    $(this).prev().val('1');
    $(this).closest('.row').hide();
  });
  $('form').on('click','.remove_row_fields', function(event){
    $(this).prev().val('1');
    $(this).closest('tr').hide();
    event.preventDefault();
  });
});