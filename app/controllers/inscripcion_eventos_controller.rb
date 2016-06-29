class InscripcionEventosController < ApplicationController
  before_action :set_inscripcion_evento, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :json, :html

  def index
    @evento = Evento.find(params[:evento_id])
    @estadisticas = InscripcionEvento.get_estadisticas(@evento)
    @inscripcion_eventos = @evento.inscripcion_eventos.where(aceptado: nil).order(:fecha)
    respond_with(@inscripcion_eventos)
  end


  def index_consulta_eventos
   @eventos = Evento.all
   @accion = params[:accion]
  end


  def show
    respond_with(@inscripcion_evento)
  end

  def new
    @inscripcion_evento = InscripcionEvento.new
    respond_with(@inscripcion_evento)
  end

  def edit
    @evento = Evento.find_by(nombre: "Escuela de Influencia y Transformación")
  end

  def create
    @inscripcion_evento = InscripcionEvento.new(inscripcion_evento_params)
    @inscripcion_evento.save
    respond_with(@inscripcion_evento)
  end

  def ver_inscripciones
    @evento = Evento.find(params[:evento_id])
    @estadisticas = InscripcionEvento.get_estadisticas(@evento)
    @inscripcion_eventos = @evento.inscripcion_eventos.order(:fecha)
    respond_with(@inscripcion_eventos)
  end

  def aprobar_preinscritos
    params[:aprobar_inscripcion].each do |f|
      @inscripcion_evento = InscripcionEvento.find(f[:id_inscripcion])
      if !f[:aceptado].nil? || !f[:rechazado].nil?
        if !f[:aceptado].nil?
          @inscripcion_evento.update(aceptado: true,nro_asiento: f[:nro_asiento],fecha_aceptado: Date.today )
          InscripcionEventoMailer.send_msg_aceptacion_evento(@inscripcion_evento).deliver
        else
          @inscripcion_evento.update(aceptado: false)
          #InscripcionEventoMailer.send_msg_no_aceptacion_evento(@inscripcion_evento).deliver
        end
      end
    end
    redirect_to root_url, notice: "El proceso de preinscritos se realizó satisfactoriamente y les fue enviado el horario y carta de aceptación al correo"

  end

  def estadisticas_inscripciones
    @paises = Pais.order(:nombre)
    @eventos = Evento.where(empresa_id: current_user.empresa_id).order(:fecha_inicio)
  end

  def procesar_estadisticas
    estadisticas = InscripcionEvento.get_estadisticas_xcriterio(params[:evento_id],params[:pais_id],params[:criterio])
    render json: [estadisticas: estadisticas]
  end

  def update
    if @inscripcion_evento.update(inscripcion_evento_params)
      msg = "Los cambios a la inscripción fueron realizados satisfactoriamente"
      if @inscripcion_evento.aceptado
        InscripcionEventoMailer.send_msg_aceptacion_evento(@inscripcion_evento).deliver
        msg = msg + " y enviada de nuevo la carta de aceptación vía email"
      end
      redirect_to root_path, notice: msg
    end
  end

  def destroy
    if @inscripcion_evento.destroy
      @contacto = Contacto.find(@inscripcion_evento.contacto_id)
      @contacto.destroy
      redirect_to root_path, notice: "La inscripción y los datos del contacto fueron eliminados satisfactoriamente"
    end
  end


  def default_or_value_view(param, value)
    param.nil? ? value : param
  end
  helper_method :default_or_value_view

  private
    def set_inscripcion_evento
      @inscripcion_evento = InscripcionEvento.find(params[:id])
    end

    def inscripcion_evento_params
      params.require(:inscripcion_evento).permit(:fecha, :nro_asiento, :fecha_pago, :nro_pago, :monto, :aceptado, :fecha_aceptado,
                                                 :contacto_id,
                                                 :evento_id,
                                                 :documento)
    end
end
