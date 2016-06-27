#= require bootstrapValidator/bootstrapValidator.js
#= require jasny/jasny-bootstrap.min

jQuery(document).ready ($) ->
  $('#form_empresa').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "empresa[denominacion]":
        validators:
          notEmpty:
            message: 'Debe ingresar la denominación'
      "empresa[abreviado]":
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre abreviado'
      "empresa[rif]":
        validators:
          notEmpty:
            message: 'Debe ingresar un rif'
          regexp:
            regexp: /^([VEJPGvejpg][-]\d{9})$/
            message: 'RIF no válido, debe ingresar un RIF válido: Ej. J-999999999'
      "empresa[direccion_fiscal]":
        validators:
          notEmpty:
            message: 'Debe ingresar una dirección fiscal'
      "empresa[telefono]":
        validators:
          notEmpty:
            message: 'Debe ingresar un teléfono'
      "pais_id":
        validators:
          notEmpty:
            message: 'Debe seleccionar un pais'
      "empresa[estado_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar un pais y un estado'
      "empresa[nombre_rl]":
        validators:
          notEmpty:
            message: 'Debe ingresar el nombre del representante legal'
      "empresa[email_rl]":
        validators:
          notEmpty:
            message: 'Debe ingresar la cuenta de correo electrónico del representante legal'
          regexp:
            regexp: /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i
            message: 'Debe ingresar su cuenta de correo electrónico. Ejemplo: aperez_12@gmail.com'
      "empresa[telefono_rl]":
        validators:
          notEmpty:
            message: 'Debe ingresar el teléfono del representante legal'
      "empresa[es_iglesia]":
        validators:
          notEmpty:
            message: 'Debe seleccionar si es miembro o no'

  $('#estado_id').parent().hide()
  estado = $('#empresa_estado_id').html()
  $('#pais_id').change ->
    pais = $('#pais_id :selected').text()
    options = $(estado).filter("optgroup[label='#{pais}']").html()
    if options
      $('#empresa_estado_id').html(options)
      $('#estado_id').parent().show()
    else
      $('#empresa_estado_id').empty()
      $('#estado_id').parent().hide()

