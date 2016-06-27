
jQuery(document).ready ($) ->

# Agregar los contactos a una tabla.
$('#btn_guardar').hide()
$('#btn_agregar_equipo').click ->
  $('#div_procesando').empty()
  $.ajax
    type: 'POST'
    url: '/agregar_equipo'
    dataType: 'JSON'
    data:
      usuario:  $('#usuarios_roles').val()
    success: (data) ->
      $('#div_table_resultados').show()
      $('#tbody_resultados').append("<tr><td>"+data[0].name+"</td><td>"+data[1]+"</td><td class=\"eliminar text-center\"><button class=\"fa fa-trash fa-2x\"></button></td></tr>")
      $('#usuarios_roles').val('')
      $('#btn_guardar').show()
    error: (XMLHttpRequest, textStatus, errorThrown) ->
      alert("No existe el registro")

# Elimina la fila indicada de la tabla de resultados.
$(document).on "click", ".eliminar", ->
  parent = $(this).parent()
  $(parent).remove()

# Guardar los contactos a un equipo.
$('#btn_guardar_equipo').click ->
  usuarios = new Array
  $('#table_resultados #tbody_resultados tr').each ->
    id = $(this).find('td').eq(0).html()
    usuarios.push(id)
    $.ajax
      type: 'POST'
      url: '/guardar_equipo'
      dataType: 'JSON'
      data:
        evento_id: $('#evento_id').val()
        usuario:  usuarios
      success: (data) ->
        console.log(data[1])
        if data
          url = ' /eventos/'+data[1]+'/equipo_gestor'
          $(location).attr 'href', url
        else
          alert('El equipo gestor no se puede crear')


#para crear una mensaje dentro del index
$('#form_equipo_index').hide()
$('#btn_nuevo_equipo').click ->
  $('#form_equipo_index').show()

