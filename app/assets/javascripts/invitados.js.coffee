
jQuery(document).ready ($) ->

  $('#btn_procesar').click ->
    if $('#desde').val() == '' && $('#hasta').val()== '' || $('#desde').val() < $('#hasta').val()
      sexos = new Array()
      estados_civiles = new Array()
      grupos = new Array()
      $('#tbody_sexo_checks input').each ->
        if (this.checked) && !(this.disabled)
          sexos.push($(this).val())
      $('#tbody_estado_civil_checks input').each ->
        if (this.checked) && !(this.disabled)
          estados_civiles.push($(this).val())
      $('#tbody_grupos_checks input').each ->
        if (this.checked) && !(this.disabled)
          grupos.push($(this).val())
      $.ajax
        type: 'POST'
        url: '/crear_listas_invitados'
        dataType: 'JSON'
        data:
          sexos: sexos
          estados_civiles: estados_civiles
          grupos: grupos
          desde: $('#desde').val()
          hasta: $('#hasta').val()
          evento_id: $('#evento_select').val()
        success: (data) ->
          if data
            url = '/listado_xevento/'+data[0].evento
            $(location).attr 'href', url

          else
            alert('No existen registros de invitados con ningun criterio seleccionado')
        error: (XMLHttpRequest, textStatus, errorThrown) ->
          alert("Al menos debe seleccionar un campo para realizar la consulta")
    else
      alert("El valor Desde debe ser menor que el valor de Hasta en la edad")


  $('#checkall_estado').click ->
    $('#tbody_estado_civil_checks input').prop('checked', this.checked);

  $('#checkall_sexo').click ->
    $('#tbody_sexo_checks input').prop('checked', this.checked);

  $('#checkall_ge').click ->
    $('#tbody_grupos_checks input').prop('checked', this.checked);



$('#form_invitado_index').hide()
$('#btn_agregar_invitado').click ->
  $('#form_invitado_index').show()


# Agregar los contactos a una tabla.
$('#btn_guardar').hide()
$('#btn_agregar').click ->
  $.ajax
    type: 'POST'
    url: '/agregar_invitado'
    dataType: 'JSON'
    data:
      contacto:  $('#contacto_nombres').val()
      evento: $('#evento').val()
    success: (data) ->
      $('#div_table_resultados').show()
      $('#tbody_resultados').append("<tr><td>"+data[0].nombres+"</td><td>"+data[0].apellidos+"</td><td>"+data[0].doc_identidad+
       "</td><td class = 'text-center' style=\"display:none;\">"+data[1]+
        "</td><td class=\"eliminar text-center\"><button class=\"fa fa-trash fa-2x\"></button></td></tr>")
      $('#contacto_nombres').val('')
      $('#btn_guardar').show()
    error: (XMLHttpRequest, textStatus, errorThrown) ->
      alert("No existe el registro")

# Elimina la fila indicada de la tabla de resultados.
$(document).on "click", ".eliminar", ->
  parent = $(this).parent()
  $(parent).remove()



# consultar el listado de los invitados según el evento.
$('#btn_buscar_invitados').click ->
  even = $('#evento_id').val()
  if even != ''
    $.ajax
      type: 'POST'
      url: '/buscar_invitados'
      dataType: 'JSON'
      data:
        evento: even
      success: (data) ->
        console.log(data)
        if data
          url = '/listado_xevento/'+data
          $(location).attr 'href', url
        else
          alert('Nos se encontraron invitados por el evento seleccionado')
  else
    alert("Debe seleccionar un evento")


# Guardar los contactos al listado de invitados.
$('#btn_guardar_invitados').click ->
  contactos = new Array
  $('#table_resultados #tbody_resultados tr').each ->
    id = $(this).find('td').eq(2).html()
    even = $(this).find('td').eq(3).html()
    contactos.push(id)
    $.ajax
      type: 'POST'
      url: '/asociar_invitado'
      dataType: 'JSON'
      data:
        evento: even
        contacto:  contactos
      success: (data) ->
        if data
          url = '/listado_xevento/'+data
          $(location).attr 'href', url
        else
          alert('El invitado no se le puede agregar')