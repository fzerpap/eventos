class MensajesController < ApplicationController

  before_action :set_mensaje, only: [:show, :edit, :update, :destroy]
  before_action :set_evento, only: [ :show,:new, :edit, :index, :update, :create, :destroy]
  before_filter :armar_breadcrumb, except: [:create, :update, :destroy]

  respond_to :html

  def index
    @mensajes = @evento_id.mensajes.all.order(:id)
    @mensaje = Mensaje.new
    respond_with(@mensajes, @mensaje)
  end

  def show
    respond_with(@mensaje)
  end

  def new
    @mensaje = Mensaje.new
    respond_with(@mensaje, @evento_id)
  end

  def edit
    p @mensaje.inspect
  end

  def create
    @mensaje = Mensaje.new(mensaje_params)
    p @mensaje.inspect
    respond_to do |format|
      if @mensaje.save
        format.html { redirect_to   evento_mensajes_path(@evento_id), notice: 'Mensaje creado existosamente.' }
      else
        format.html { render :new }
        format.json { render json: @mensaje.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @mensaje.update(mensaje_params)
        format.html { redirect_to   evento_mensajes_path(@evento_id), notice: 'Mensaje actualizado existosamente.' }
      else
        format.html { render :new }
        format.json { render json: @mensaje.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @mensaje.destroy
      respond_to do |format|
        format.html { redirect_to  evento_mensajes_path(@evento_id), notice: 'Mensaje eliminado existosamente.' }
      end
    end
  end

  private
    def set_mensaje
      @mensaje = Mensaje.find(params[:id])
    end

    def set_evento
      @evento_id = Evento.find(params[:evento_id])
    end


    def mensaje_params
      params.require(:mensaje).permit(:asunto, :remitente, :descripcion, :asiento, :coordinador, :enlace, :archivo_adjunto, :evento_id)
    end

  def self.permission
    :Mensaje
  end
end
