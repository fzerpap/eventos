jQuery(document).ready ($) ->

#para crear un plan dentro del index
$('#form_plan').hide()
$('#btn_crear_plan').click ->
  $('#form_plan').attr('disabled', false)
  $('#form_plan').show()