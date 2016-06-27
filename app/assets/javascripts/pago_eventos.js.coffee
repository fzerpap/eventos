#= require jasny/jasny-bootstrap
#= require lightbox/js/lightbox.min.js
#= require jquery-fileupload
#= require document_upload
#= require datable.js
#= require bootstrapValidator/bootstrapValidator.js
#= require jasny/jasny-bootstrap.min
#= require dataTables/jquery.dataTables.js
#= require dataTables/dataTables.bootstrap.js
#= require dataTables/dataTables.responsive.js
#= require dataTables/dataTables.tableTools.min.js



jQuery(document).ready ($) ->


  $('#btn_procesar').click ->
    $(this).prop('disabled', 'disabled')
    $('#msg_procesando').show()
    $('#div_procesando').empty()
    $.ajax
      type: 'POST'
      url: 'obtener_inscrito_evento'
      dataType: 'HTML'
      data:
        email: $('#email_text').val()
      success: (data) ->
        $('#msg_procesando').hide()
        $('#div_registro_pago').show()
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        $('#msg_procesando').hide()
        alert("No existe ningún participante con el e-mail ingresado")

