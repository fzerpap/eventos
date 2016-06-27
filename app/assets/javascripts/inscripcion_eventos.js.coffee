#= require jasny/jasny-bootstrap
#= require lightbox/js/lightbox.min.js
#= require jquery-fileupload
#= require document_upload
#= require datable.js
#= require bootstrapValidator/bootstrapValidator.js
#= require dataTables/jquery.dataTables.js
#= require dataTables/dataTables.bootstrap.js
#= require dataTables/dataTables.responsive.js
#= require dataTables/dataTables.tableTools.min.js



jQuery(document).ready ($) ->


  $('#btn_procesar_estadisticas').click ->
    $(this).prop('disabled', 'disabled')
    $('#msg_procesando').show()
    $('#div_procesando').empty()
    $.ajax
      type: 'POST'
      url: 'procesar_estadisticas'
      dataType: 'JSON'
      data:
        criterio: $('input:radio[name=criterio]:checked').val()
        evento_id: $('#evento_select').val()
        pais_id: $('#pais_select').val()
      success: (data) ->
        $('#msg_procesando').hide()
        $('#div_table_resultados').show()
        $('#tbody_resultados').empty()
        $('#table_resultados').append(data)
        $('#table_resultados').append(data)
        for est, index in data[0]['estadisticas']
          $('#tbody_resultados').append("<tr><td class = 'text-left'>"+est.criterio+"</td><td class = 'text-right'>"+est.total+
            "</td><td class = 'text-right'>"+est.aceptados+"</td><td class = 'text-right'>"+est.rechazados+
            "</td><td class = 'text-right'>"+est.por_aprobar+"</td></tr>")
        $("#table_resultados").tablesorter()
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        $('#msg_procesando').hide()
        alert("No existe registros para esta consulta o existen campos no seleccionados")

angular
.module('inscripcionEventos', [])
.controller( "InscripcionEventosController", @InscripcionEventosController = ($scope,$http) ->
  $scope.evento_id =  ''
  $scope.pais_id = ''
  $scope.criterio = "estado"
  $scope.est = 0
  $scope.mostrar_resultados = false
  $scope.mostrar_procesando = false

  $scope.procesarEstadisticas = () ->
    $scope.mostrar_procesando = true
    console.log("Entró al java script")
    $http.post("procesar_estadisticas",{evento_id: $scope.evento_id, pais_id: $scope.pais_id, criterio: $scope.criterio})
      .success = ((response) ->
        alert("Tengo la respuesta http")
        $scope.est = response.data
        console.log($scope.est)
        $scope.mostrar_resultados = true
        $scope.mostrar_procesando = false
        return)
      .error = ((response) ->
        alert("Error en http")
        console.log("Error en http")
        return)

)





