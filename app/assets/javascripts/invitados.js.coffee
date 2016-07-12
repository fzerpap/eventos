
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
        url: '/listar_invitados'
        dataType: 'JSON'
        data:
          sexos: sexos
          estados_civiles: estados_civiles
          grupos: grupos
          desde: $('#desde').val()
          hasta: $('#hasta').val()
          evento_id: $('#evento_select').val()
        success: (data) ->
          console.log('paso')
          if data != 0

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