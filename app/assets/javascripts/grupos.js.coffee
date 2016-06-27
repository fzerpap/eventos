#= require bootstrapValidator/bootstrapValidator.js
#= require jasny/jasny-bootstrap.min

jQuery(document).ready ($) ->

# Agregar los contactos a una tabla.
$('#btn_guardar').hide()
$('#btn_agregar').click ->
  $('#div_procesando').empty()
  $.ajax
    type: 'POST'
    url: '/agregar_contacto'
    dataType: 'JSON'
    data:
      contacto:  $('#contacto_nombres').val()
    success: (data) ->
      $('#div_table_resultados').show()
      $('#tbody_resultados').append("<tr><td>"+data[0].nombres+"</td><td>"+data[0].apellidos+"</td><td>"+data[0].doc_identidad+
        "</td><td class = 'text-center'>"+data[1]+"<td class = 'text-center'>"+data[0].email+
        "</td><td class = 'text-center'>"+data[0].telefono+"</td><td class=\"eliminar text-center\"><button class=\"fa fa-trash fa-2x\"></button></td></tr>")
      $('#contacto_nombres').val('')
      $('#btn_guardar').show()
    error: (XMLHttpRequest, textStatus, errorThrown) ->
      alert("No existe el registro")

# Elimina la fila indicada de la tabla de resultados.
$(document).on "click", ".eliminar", ->
  parent = $(this).parent()
  $(parent).remove()

# Crear el grupo.
$('#btn_crear_grupo').click ->
  $.ajax
    type: 'POST'
    url: '/grupos'
    dataType: 'JSON'
    data:
      grupo:  $('#nombre').val()
      empresa_id:  $('#empresa_id').val()
    success: (data) ->
      $('#nombre').val(data[0].nombre)
      $('#nombre').attr('disabled', true)
      $('#btn_crear_grupo').hide()
      $('#div_asociar').show()
    error: (XMLHttpRequest, textStatus, errorThrown) ->
      $('#nombre').attr('disabled', false)
      $('#div_asociar').hide()
      alert("No se pudo registrar el grupo")

# Agregar los contactos a un grupo.
$('#btn_agregar_contactos').click ->
  contactos = new Array
  $('#table_resultados #tbody_resultados tr').each ->
    id = $(this).find('td').eq(2).html()
    contactos.push(id)
    $.ajax
      type: 'POST'
      url: '/asociar_contacto'
      dataType: 'JSON'
      data:
        grupo:  $('#nombre').val()
        contacto:  contactos
      success: (data) ->
        console.log(data)
        if data
          url = '/grupos'
          $(location).attr 'href', url
        else
          alert('El grupo no se le puede asociar los contactos')