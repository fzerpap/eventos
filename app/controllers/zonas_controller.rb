class ZonasController < ApplicationController
  before_filter :armar_breadcrumb, except: [:create, :update, :destroy]
  before_action :set_zona, only: [ :show, :edit, :update, :destroy]
  before_action :set_evento, only: [ :show,:new, :edit, :index, :update, :create]

  respond_to :html

  def index
    @zonas = @evento_id.zonas.all.order(:id)
    @zona = Zona.new
    respond_with(@zonas, @evento_id)
  end

  def show
    respond_with(@zona)
  end

  def new
    @zona = Zona.new
    respond_with(@zona, @evento_id)
  end

  def edit
    respond_with(@zona, @evento_id)
  end

  def create
    @zona = Zona.new(zona_params)
    respond_to do |format|
      if @zona.save
        format.html { redirect_to  evento_zonas_path(evento_id: @evento_id), notice: 'Zona creada existosamente.' }
      else
        format.html { render :new }
        format.json { render json: @zona.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    respond_to do |format|
      if  @zona.update(zona_params)
        format.html { redirect_to  evento_zonas_path(evento_id: @evento_id), notice: 'Zona actualizada existosamente.' }
      else
        format.html { render :new }
        format.json { render json: @zona.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @zona.destroy
    respond_to do |format|
      format.html { redirect_to  evento_zonas_path(params[:evento_id]), notice: 'Zona eliminada existosamente.' }
    end
  end

  private
    def set_evento
      @evento_id = Evento.find(params[:evento_id])
    end

    def set_zona
      @zona = Zona.find(params[:id])
    end

    def zona_params
      params.require(:zona).permit(:nombre, :cupos, :precio, :num_asiento_inicial, :num_asiento_final, :evento_id)
    end

  def self.permission
    :Zona
  end
end
