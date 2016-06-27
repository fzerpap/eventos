class ContactosController < ApplicationController

  before_action :set_contacto, only: [:show, :show_contacto, :edit, :edit_contacto, :update, :update_contacto, :destroy]

  before_action :authenticate_user!, only: [ :index,  :destroy]


  respond_to :html, :json

  def index
    @contactos = Contacto.all
    @fuente = 'contacto'
    respond_with(@contactos)
  end

  def show_contacto
    @empresa = Empresa.find(params[:em])
    respond_with(@contacto, @empresa)
  end

  def show
    respond_with(@contacto)
  end

  def new_contacto
    @empresa = Empresa.find(params[:id_empresa])
    @evento = Evento.find(params[:id_evento])
    @contacto = Contacto.new
    @contacto.contacto_empresas.build
    respond_with(@contacto, @empresa, @evento)
  end

  def new
    @contacto = Contacto.new
    @contacto.contacto_empresas.build
    respond_with(@contacto)
  end

  def edit
  end

  def edit_contacto
    @empresa = Empresa.find(params[:em])
    respond_with(@empresa)
  end

  # Crea el contacto
  def create_contacto
    id = params[:contacto][:contacto_empresas_attributes]['0'][:empresa_id].to_i
    empresa = Empresa.find(id)
    empresa.es_iglesia? ? pais_id = Pais.find(params[:pais_id]).codigo : pais_id = Pais.find(params[:pais][:id]).codigo
    parametros = nc_params(contacto_params, pais_id, params[:telef] )
    @contacto = Contacto.new(parametros)
    if @contacto.save
      redirect_to  show_contacto_path(id: @contacto.id, em: empresa.id), notice: 'El contacto fué creado satisfactoriamente y agregado a la lista de contactos'
    else
      redirect_to  root_path, alert: 'El contacto no se ha creado satisfactoriamente'
    end
  end

  # Crea el contacto y la preinscripción al evento "Escuela de Influencia y Transformación"
  def create
    @contacto = Contacto.new(contacto_params)
    if @contacto.save
      InscripcionEvento.create!(fecha: Date.today,evento: Evento.find_by(nombre: 'Escuela de Influencia y Transformación'),
      contacto: Contacto.find_by(email: contacto_params[:email]),aceptado: nil)
    end
    respond_with(@contacto)
  end

  def update
    @contacto.update(contacto_params)
    respond_with(@contacto)
  end

  def update_contacto
    @empresa = ContactoEmpresa.find_by_contacto_id(@contacto.id).empresa
    @empresa.es_iglesia? ? pais_id = Pais.find(params[:pais_id]).codigo : pais_id = Pais.find(params[:pais][:id]).codigo
    parametros = nc_params(contacto_params, pais_id, params[:telef] )
    if @contacto.update(parametros)
      redirect_to  show_contacto_path(id: @contacto.id, em: @empresa.id), notice: 'Los cambios al contacto fueron actualizados satisfactoriamente y agregados a la lista de contactos'
    else
      redirect_to  show_contacto_path(id: @contacto.id, em: @empresa.id), alert: 'Los cambios al contacto no fueron actualizados debido a duplicidad en el correo o documento de identidad'
    end
  end


  def destroy
    if @contacto.destroy
      redirect_to contactos_path, notice: 'El contacto eliminado satisfactoriamente de la lista de contactos'
    else
      redirect_to contactos_path, alert: 'El contacto no puede ser eliminado ya que contiene inscripciones asociadas'
    end
  end


  private
    def set_contacto
      @contacto = Contacto.find(params[:id])
    end

    def contacto_params
      params.require(:contacto).permit(:nombres,
                                       :apellidos,
                                       :doc_identidad,
                                       :fecha_nac,
                                       :email,
                                       :email_confirmation,
                                       :telefono,
                                       :hijos,
                                       :estado_civil,
                                       :sexo,
                                       :estado_id,
                                       :profesion_id,
                                       :ministerio_id,
                                       contacto_empresas_attributes:  [:id, :es_miembro, :empresa_id ]
      )
    end
  #constructor de los parametros del contacto
  def nc_params(*contacto_params, oper, telef)
    {
        nombres: params[:contacto][:nombres].upcase,
        apellidos: params[:contacto][:apellidos].upcase,
        doc_identidad: params[:contacto][:doc_identidad],
        fecha_nac: (params[:contacto]['fecha_nac(3i)']).to_s + '-' + (params[:contacto]['fecha_nac(2i)']).to_s + '-' + (params[:contacto]['fecha_nac(1i)']).to_s,
        email: params[:contacto][:email],
        telefono: oper + telef,
        hijos: params[:contacto][:hijos],
        estado_civil: params[:contacto][:estado_civil],
        sexo: params[:contacto][:sexo],
        estado_id: params[:contacto][:estado_id],
        profesion_id: params[:contacto][:profesion_id],
        ministerio_id: params[:contacto][:ministerio_id],
        contacto_empresas_attributes: params[:contacto][:contacto_empresas_attributes]
    }
  end

  before_filter do
    resource = controller_path.singularize.gsub('/', '_').to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def self.permission
    :Contacto
  end
end
