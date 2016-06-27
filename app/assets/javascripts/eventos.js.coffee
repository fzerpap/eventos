#= require bootstrapValidator/bootstrapValidator

jQuery(document).ready ->

  $('#form_evento').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "evento[nombre]":
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre'
      "evento[descripcion]":
        validators:
          notEmpty:
            message: 'Debe ingresar una descripción'
      "evento[num_invitados]":
        validators:
          notEmpty:
            message: 'Debe ingresar la cantidad de cupos del evento'
          numeric:
            message: 'El valor no es numérico'
      "evento[lugar]":
        validators:
          notEmpty:
            message: 'Debe ingresar el lugar del evento'
      "evento[horario]":
        validators:
          notEmpty:
            message: 'Debe ingresar el horario del evento'



  $('#tipo_plan_select').on 'change', ->
    plan = $('#tipo_plan_select').val()
    if plan != ''
      $.ajax
        type: 'POST'
        url: '/plan'
        dataType: 'JSON'
        data:
          plan:  plan
        success: (data) ->
          $('#evento_tipo_plan_id').val(data[0]['id'])
          switch data[0]['id']
            when 1
              console.log('libre')
              $('#form_libre').show()
              $('#form_intermedio').hide()
              $('#form_full').hide()
              $('#evento_tipo_plan_id').val( data[0]['id'])
            when 2
              console.log('intermedio')
              $('#form_libre').show()
              $('#form_intermedio').show()
              $('#form_full').hide()
              $('#evento_tipo_plan_id').val( data[0]['id'])
            when 3
              console.log('full')
              $('#form_libre').show()
              $('#form_intermedio').hide()
              $('#form_full').show()
              $('#evento_tipo_plan_id').val( data[0]['id'])
        error: (XMLHttpRequest, textStatus, errorThrown) ->
          $('#form_libre').hide()
          $('#form_intermedio').hide()
          $('#form_full').hide()
          alert("No se pudo registrar el evento")
    else
      $('#form_libre').hide()
      $('#form_intermedio').hide()
      $('#form_full').hide()


  #para crear un plan dentro del index
  $('#form_evento_index').hide()
  $('#btn_nuevo_evento').click ->
    $('#form_evento_index').show()


#para el rango de fecha inicio y fecha fin sea mayor
$('#evento_fecha_fin_1i').change ->
  console.log('hola1')
  d1 = $('#evento_fecha_inicio_3i').val()
  m1 = $('#evento_fecha_inicio_2i').val()
  a1 = $('#evento_fecha_inicio_1i').val()
  d2 = $('#evento_fecha_fin_3i').val()
  m2 = $('#evento_fecha_fin_2i').val()
  a2 = $('#evento_fecha_fin_1i').val()

  fecha1 = d1+'-'+m1+'-'+ a1
  fecha2 = d2+'-'+m2+'-'+ a2
  f1 = stringToDate(fecha1,"dd-mm-yyyy","-")
  f2 = stringToDate(fecha2,"dd-mm-yyyy","-")
  if(f2 < f1)
    alert('La fecha finalización es menor a la fecha de inicio del evento')
    $('#evento_fecha_fin_1i').val('')
    $('#evento_fecha_fin_3i').val('')
    $('#evento_fecha_fin_2i').val('')

$('#evento_fecha_fin_2i').change ->
  console.log('hola2')
  d1 = $('#evento_fecha_inicio_3i').val()
  m1 = $('#evento_fecha_inicio_2i').val()
  a1 = $('#evento_fecha_inicio_1i').val()
  d2 = $('#evento_fecha_fin_3i').val()
  m2 = $('#evento_fecha_fin_2i').val()
  a2 = $('#evento_fecha_fin_1i').val()

  fecha1 = d1+'-'+m1+'-'+ a1
  fecha2 = d2+'-'+m2+'-'+ a2
  f1 = stringToDate(fecha1,"dd-mm-yyyy","-")
  f2 = stringToDate(fecha2,"dd-mm-yyyy","-")
  if(f2 < f1)
    alert('La fecha finalización es menor a la fecha de inicio del evento')
    $('#evento_fecha_fin_1i').val('')

$('#evento_fecha_fin_3i').change ->
  console.log('hola3')
  d1 = $('#evento_fecha_inicio_3i').val()
  m1 = $('#evento_fecha_inicio_2i').val()
  a1 = $('#evento_fecha_inicio_1i').val()
  d2 = $('#evento_fecha_fin_3i').val()
  m2 = $('#evento_fecha_fin_2i').val()
  a2 = $('#evento_fecha_fin_1i').val()

  fecha1 = d1+'-'+m1+'-'+ a1
  fecha2 = d2+'-'+m2+'-'+ a2
  f1 = stringToDate(fecha1,"dd-mm-yyyy","-")
  f2 = stringToDate(fecha2,"dd-mm-yyyy","-")
  if(f2 < f1)
    alert('La fecha finalización es menor a la fecha de inicio del evento')



stringToDate = (_date, _format, _delimiter) ->
  formatLowerCase = _format.toLowerCase()
  formatItems = formatLowerCase.split(_delimiter)
  dateItems = _date.split(_delimiter)
  monthIndex = formatItems.indexOf('mm')
  dayIndex = formatItems.indexOf('dd')
  yearIndex = formatItems.indexOf('yyyy')
  month = parseInt(dateItems[monthIndex])
  month -= 1
  formatedDate = new Date(dateItems[yearIndex], month, dateItems[dayIndex])
  formatedDate


