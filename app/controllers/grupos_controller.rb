class GruposController < ApplicationController

  before_action :set_grupo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :asociar_grupo_contactos]

  respond_to :html, :json

  def index
    @grupos = Grupo.all
    respond_with(@grupos)
  end

  def show
    respond_with(@grupo)
  end

  def new
    @grupo = Grupo.new
    @new = true
    respond_with(@grupo)
  end

  def edit
    @new = false
  end

  def create
    @grupo = Grupo.create(nombre: params[:grupo], empresa_id: params[:empresa_id].to_i)
    if @grupo.save
      render json: [@grupo]
    else
      redirect_to new_grupo_path, alert: 'El grupo no se creado sastifactoriamente'
    end
  end

  def update
    @grupo.update(grupo_params)
    respond_with(@grupo)
  end

  def destroy
    @grupo.destroy
    respond_with(@grupo)
  end

  def autocomplete_contacto_nombres
    term = params[:term].upcase
    contactos = Contacto.where('nombres LIKE ? or apellidos LIKE ?', "%#{term}%","%#{term}%" ).order(:nombres).all
    render json:  contactos.map {|contact| {:id => contact.id, :label => contact.nombres + ' ' + contact.apellidos + ', ' + contact.doc_identidad, :value => contact.nombres + ' ' + contact.apellidos + ', ' + contact.doc_identidad }}
  end

  def agregar_contactos
    @cont = Contacto.find_by(doc_identidad: Grupo.formatear_doc_identidad(params[:contacto]))
    render json: [@cont, @cont.profesion.nombre]
  end

  def asociar_grupo_contactos
    @grupo = Grupo.find_by_nombre(params[:grupo])
    @contacto_grupo = Grupo.asociar_grupo_contacto(params[:grupo], params[:contacto])
    render json: @contacto_grupo
  end

  def eliminar_contactos
    @contacto_grupo = ContactoGrupo.find(params[:id])
    @contacto_grupo.destroy
  end

  private
  def set_grupo
    @grupo = Grupo.find(params[:id])
  end

  def grupo_params
    params.require(:grupo).permit( :nombre,
                                   :empresa_id,
                                   contacto_grupos_attributes:  [:id, :grupo_id, :contacto_id ]
    )
  end

  def self.permission
    :Grupo
  end
end
