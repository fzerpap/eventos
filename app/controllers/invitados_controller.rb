class InvitadosController < ApplicationController
  before_action :set_invitado, only: [:show, :edit, :update, :destroy]
  before_action :set_evento, only: [:lista_xevento, :buscar_invitados, :agregar_invitados, :listar_invitados]

  respond_to :html, :json

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

  def update
    @invitado.update(invitado_params)
    respond_with(@invitado)
  end

  def destroy
    @invitado.destroy
    respond_with(@invitado)
  end

  def buscar_invitados
    render json: @evento.id
  end

  def lista_xevento
    @invitados = Invitado.where(evento_id: @evento.id)
    respond_with(@invitados, @evento)
  end

  def crear_listas_invitados
    filtro = Invitado.formatear_filtros(params[:evento_id], params[:grupos], params[:sexos], params[:estados_civiles], params[:desde], params[:hasta] )
    invitados = Invitado.crear_lista(filtro)
    render json: [invitados: invitados, evento: params[:evento_id] ]
  end


  def autocomplete_contactos_invitados
    term = params[:term].upcase
    contactos = Contacto.where('nombres LIKE ? or apellidos LIKE ?', "%#{term}%","%#{term}%" ).order(:nombres).all
    render json:  contactos.map {|contact| {:id => contact.id, :label => contact.nombres + ' ' + contact.apellidos + ', ' + contact.doc_identidad, :value => contact.nombres + ' ' + contact.apellidos + ', ' + contact.doc_identidad }}
  end

  def agregar_invitados
    @cont = Contacto.find_by(doc_identidad: Invitado.formatear_doc_identidad(params[:contacto]))
    render json: [@cont, @evento.nombre]
  end

  def asociar_invitado_contactos
    evento = Evento.find_by_nombre(params[:evento])
    @invitado = Invitado.asociar_invitado_contacto( params[:contacto], evento)
    render json: evento.id
  end

  def delete_many
    Invitado.where('evento_id= ?', params[:evento_id]).delete_all
    redirect_to invitados_path, notice: 'Lista de Invitados eliminada satisfactoriamente.'
  end

  private
    def set_invitado
      @invitado = Invitado.find(params[:id])
    end

    def set_evento
      @evento = Evento.find(params[:evento])
    end

    def invitado_params
      params.require(:invitado).permit(:fecha_invitacion, :fecha_confirmacion, :tipo_confirmacion, :contacto_id, :evento_id)
    end

    def self.permission
      :Invitado
    end

end
