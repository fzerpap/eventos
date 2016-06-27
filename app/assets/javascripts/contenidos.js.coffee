#= require bootstrapValidator/bootstrapValidator
#= require jquery-fileupload
#= require bootstrap/modal
#= require video/responsible-video

jQuery(document).ready ($) ->

  $('#new_contenido').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "contenido[titulo]":
        validators:
          notEmpty:
            message: 'Debe ingresar un Titulo'
      "contenido[autor]":
        validators:
          notEmpty:
            message: 'Debe ingresar un Autor'
      "contenido[palabras_claves]":
        validators:
          notEmpty:
            message: 'Debe ingresar al menos una palabra clave'
      "contenido[tipo_archivo]":
        validators:
          notEmpty:
            message: 'Debe seleccionar un Tipo de Archivo'
      "contenido[nombre_archivo]":
        validators:
          notEmpty:
            message: 'Debe ingresar una URL para el Archivo'
      "contenido[tipo_contenido_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar un Tipo de Contenido'
      "contenido[contenido_eventos_attributes][0][evento_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar un Evento'

  $('#btn_procesar').click ->

    $.ajax
      type: 'POST'
      url: '/buscar/contenido_eventos'
      dataType: 'JSON'
      data:
        evento_id: $('#evento_select_tag').val()
      success: (data) ->
        console.log(data)
        $('#msg_procesando').hide()
        $('#div_table_resultados').show()
        $('#tbody_resultados').empty()
        $('#table_resultados').append(data)
        for ce, index in data[0]['contenido']
          $('#tbody_resultados').append("<tr><td>"+ce.titulo+"</td><td>"+ce.autor+"</td><td>"+ce.nombre_archivo+"</td>" +
            "<td>"+ce.tipo_contenido+"</td><td>"+ce.tipo_archivo+"</td></tr>")

      error: (XMLHttpRequest, textStatus, errorThrown) ->
        $('#msg_procesando').hide()
        alert("No existe registros para esta consulta o existen campos no seleccionados")


