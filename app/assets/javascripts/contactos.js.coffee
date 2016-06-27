#= require dataTables/jquery.dataTables.js
#= require dataTables/dataTables.bootstrap.js
#= require dataTables/dataTables.responsive.js
#= require dataTables/dataTables.tableTools.min.js
#= require bootstrapValidator/bootstrapValidator.js
#= require jasny/jasny-bootstrap.min

jQuery(document).ready ($) ->
  $('#new_contacto').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "contacto[nombres]":
        validators:
          notEmpty:
            message: 'Debe ingresar sus nombres'
      "contacto[apellidos]":
        validators:
          notEmpty:
            message: 'Debe ingresar sus apellidos'
      "contacto[doc_identidad]":
        validators:
          notEmpty:
            message: 'Debe ingresar su nro. de documento de identidad'
      "contacto[email]":
        validators:
          notEmpty:
            message: 'Debe ingresar su cuenta de correo electrónico'
          regexp:
            regexp: /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i
            message: 'Debe ingresar su cuenta de correo electrónico. Ejemplo: aperez_12@gmail.com'
      "contacto[email_confirmation]":
        validators:
          notEmpty:
            message: 'Debe confirmar su cuenta de correo electrónico'
          regexp:
            regexp: /^([\w.-]+)@([\w.-]+)\.([a-zA-Z.]{2,6})$/i
            message: 'Debe ingresar su cuenta de correo electrónico. Ejemplo: aperez_12@gmail.com'
          identical:
            field: 'contacto[email]',
            message: 'El email y su confirmación no coinciden'
      "contacto[estado_civil]":
        validators:
          notEmpty:
            message: 'Debe seleccionar un estado civil'
      "contacto[sexo]":
        validators:
          notEmpty:
            message: 'Debe seleccionar el sexo al que pertenece'
      "contacto[profesion_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar su profesión'
      "telef":
        validators:
          notEmpty:
            message: 'Debe ingresar un numero de telefono'
          regexp:
            regexp: /^[0-9]+$/,
            message: 'El teléfono solo puede contener números'

    #Activar el estado y el telefono
    $('#estado').hide()
    $('#telefono').hide()
    $('#pais_id').change ->
      if $('#pais_id').val() != ''
        $.ajax
          type: "POST"
          url: "/dynamic_select/dynamic_estado"
          dataType: "JSON"
          data:
            pais_id: $('#pais_id').val()
          success: (data) ->
            $('#estado').show()
            html_estado_select = $('#contacto_estado_id')
            html_estado_select.empty()
            $(data[0]['estados']).each (i, v) -> # indice, valor
              html_estado_select.append("<option value=\"" + v.id + "\">" + v.nombre + "</option>")

        $.ajax
          type: "POST"
          url: " /dynamic_select/dynamic_pais"
          dataType: "JSON"
          data:
            pais_id: $('#pais_id').val()
          success: (data) ->
            $('#telefono').show()
            $('#codigo_pais').val( data[0]['codigo'])
            $('#codigo_pais').prop "disabled", true
      else
        $('#estado').hide()
        $('#telefono').hide()

    #Activar si es miembro
    $('#es_miembro').hide()
    $('#contacto_contacto_empresas_attributes_0_es_miembro_true').change ->
      $('#es_miembro').show()
    $('#contacto_contacto_empresas_attributes_0_es_miembro_false').change ->
      $('#es_miembro').hide()

