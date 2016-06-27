#= require bootstrapValidator/bootstrapValidator

jQuery(document).ready ->
  #para crear una zona dentro del index
  $('#form_zona_index').hide()
  $('#btn_nuevo_zona').click ->
    $('#form_zona_index').show()

  $('#form_zona').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "zona[nombre]":
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre'
      "zona[cupos]":
        validators:
          notEmpty:
            message: 'Debe ingresar la cantidad de cupos'
          numeric:
            message: 'El valor no es numérico'
      "zona[precio]":
        validators:
          notEmpty:
            message: 'Debe ingresar la cantidad para el precio'
          numeric:
            message: 'El valor no es numérico'
      "zona[num_asiento_inicial]":
        validators:
          notEmpty:
            message: 'Debe ingresar un número de asiento inicial'
      "zona[num_asiento_final]":
        validators:
          notEmpty:
            message: 'Debe ingresar un número de asiento final'

