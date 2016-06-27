class EventosController < ApplicationController
  before_action :set_evento, only: [:show, :edit, :update, :destroy]
  before_action :armar_breadcrumb, except: [:update, :create, :destroy]

  respond_to :html, :json

  def index
    @eventos = Evento.all.order(:id)
    @evento = Evento.new
    respond_with(@eventos)
  end

  def show
    respond_with(@evento)
  end

  def new
    @evento = Evento.new
    respond_with(@evento)
  end

  def edit
    @evento = Evento.find(params[:id])
    @plan = TipoPlan.find( @evento.tipo_plan_id).id
    respond_with(@evento, @plan)
  end

  def create
    @evento = Evento.new(evento_params)
    respond_to do |format|
      if @evento.save
        format.html { redirect_to  new_evento_zona_path(@evento.id), notice: 'Evento creado existosamente.' }
      else
        format.html { render :new }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @evento.update(evento_params)
        format.html { redirect_to  new_evento_zona_path(@evento.id), notice: 'Evento actualizado existosamente.' }
      else
        format.html { render :new }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @evento.destroy
    respond_with(@evento)
  end

  def verificar_plan
    plan = TipoPlan.find_by(nombre: params[:plan])
    render json: [id: plan.id]
  end



  private
    def set_evento
      @evento = Evento.find(params[:id])
    end

    def evento_params
      params.require(:evento).permit(:nombre,
                                     :descripcion,
                                     :fecha_inicio,
                                     :fecha_fin,
                                     :num_invitados,
                                     :lugar,
                                     :horario,
                                     :servicios,
                                     :aprobacion,
                                     :fecha_limite_pago,
                                     :fecha_limite_baja,
                                     :porc_penalizacion,
                                     :empresa_id,
                                     :tipo_plan_id
      )
    end
end
