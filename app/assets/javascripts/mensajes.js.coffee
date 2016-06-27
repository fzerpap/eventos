#= require jasny/jasny-bootstrap.min
#= require jquery-fileupload
#= require bootstrapValidator/bootstrapValidator

jQuery(document).ready ->
  #para crear una mensaje dentro del index
  $('#form_mensaje_index').hide()
  $('#btn_nuevo_mensaje').click ->
    $('#form_mensaje_index').show()


  $('#form_mensaje').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "mensaje[asunto]":
        validators:
          notEmpty:
            message: 'Debe ingresar un asunto'
      "mensaje[descripcion]":
        validators:
          notEmpty:
            message: 'Debe ingresar una descripción en el mensaje'
