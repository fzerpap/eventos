class InvitadosController < ApplicationController
  before_action :set_invitado, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @invitados = Invitado.all
    respond_with(@invitados)
  end

  def show
    respond_with(@invitado)
  end

  def new
    @invitado = Invitado.new
    respond_with(@invitado)
  end

  def edit
  end

  def create
    @invitado = Invitado.new(invitado_params)
    @invitado.save
    respond_with(@invitado)
  end

  def update
    @invitado.update(invitado_params)
    respond_with(@invitado)
  end

  def destroy
    @invitado.destroy
    respond_with(@invitado)
  end

  def crear_listas_invitados
    filtro = Invitado.formatear_filtros(params[:evento_id], params[:grupos], params[:sexos], params[:estados_civiles], params[:desde], params[:hasta] )
    p filtro.inspect
    invitados = Invitado.consulta(filtro)
    p invitados
    render json: [invitados: invitados]
  end

  private
    def set_invitado
      @invitado = Invitado.find(params[:id])
    end

    def invitado_params
      params.require(:invitado).permit(:fecha_invitacion, :fecha_confirmacion, :tipo_confirmacion, :contacto_id, :evento_id)
    end

    def self.permission
      :Invitado
    end

end
