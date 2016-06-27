class PagoEventosController < ApplicationController

  def index
    #@eventos = Evento.where(empresa_id: current_user.empresa_id).order(:fecha_inicio)

    @evento = Evento.find_by(nombre: "Escuela de Influencia y Transformación")

    @estadisticas = InscripcionEvento.get_estadisticas_pagos(@evento)
    @pagos_evento = @evento.inscripcion_eventos.where('aceptado =? and monto >?','true','0')
    #respond_with(@inscripcion_eventos)
  end

  def registro_pago
    @evento = Evento.find_by(nombre: "Escuela de Influencia y Transformación")
  end

  def obtener_inscrito_evento
    contacto = Contacto.find_by(email: params[:email])
    if !contacto.nil?
      @inscripcion_evento = InscripcionEvento.where(contacto_id: contacto.id,evento_id: params[:evento][:evento]).first
      if !(@inscripcion_evento.nil?)
        render "form"
        return
      end
    end
    redirect_to registro_pago_evento_path, alert: "No existe ningún participante con el e-mail ingresado"
  end

  def update_pago
    @inscripcion_evento = InscripcionEvento.find(params[:id])
    fecha_pago = (params[:inscripcion_evento]['fecha_pago(1i)']+'/'+params[:inscripcion_evento]['fecha_pago(2i)']+'/'+params[:inscripcion_evento]['fecha_pago(3i)']).to_date
    if params[:inscripcion_evento]['fuente'] == 'registrar_pago'
      pago_validado = false
      notice = "Su ofrenda fué registrada satisfactoriamente. Una vez verificada, le enviaremos los datos de acceso"
      pagina = root_path
    else
      pago_validado = params[:inscripcion_evento]['pago_validado'] == '1' ? true : false
      notice = "La ofrenda fué validada y el usuario fué creado y enviada una notificación vía e-mail"
      pagina = pago_eventos_index_path
    end
    repetido = InscripcionEvento.where(evento_id: @inscripcion_evento.evento_id,nro_pago: params[:inscripcion_evento]['nro_pago']).first

    if !repetido.nil?
       notice = 'No se puede registrar la ofrenda. El nro de confirmación o depósito ya existe'
       pagina = registro_ofrenda_path
       redirect_to pagina, notice: notice
    else
      if @inscripcion_evento.update(pago_validado: pago_validado, fecha_pago: fecha_pago,nro_pago: params[:inscripcion_evento]['nro_pago'],monto: params[:inscripcion_evento]['monto'].to_d, documento: params[:inscripcion_evento]['documento'])
        redirect_to pagina, notice: notice
      else
        redirect_to pagina, alert: "Error: El registro no fue actualizado. Intente de nuevo"
      end

    end

  end


  def validar_pago
    @inscripcion_evento = InscripcionEvento.find(params[:id])
    puts @inscripcion_evento.id
    @fuente = 'validar_pago'
    render "form"
  end

  private
    def self.permission
      :pago_eventos
    end

end
