class EquipoGestorController < ApplicationController
  before_action :set_equipo_gestor, only: [ :destroy]
  before_action :set_evento, only: [ :index, :new, :guardar_equipo_gestor, :destroy]
  before_filter :armar_breadcrumb, except: [:destroy]

  respond_to :html

  def index
    @equipo_gestores = @evento_id.equipo_gestores.all.order(:id)
    respond_with(@equipo_gestores,  @evento_id)
  end

  def new
    respond_with( @evento_id)
  end

  def autocomplete_usuarios_roles
    usuarios = User.where('name LIKE ? and not (role_id = 1 or role_id = 2)', "%#{params[:term]}%" ).order(:name)
    render json:  usuarios.includes(:role).map {|users| {:id => users.id, :label => users.name + ' , ' + users.role.name, :value => users.name + ' , ' + users.role.name }}
  end

  def agregar_equipo
    @cont = User.find_by_name(EquipoGestor.formatear_usuario(params[:usuario]))
    render json: [@cont, @cont.role.name]
  end

  def guardar_equipo_gestor
    @evento_id = params[:evento_id]
    @equipo_gestor = EquipoGestor.asociar_equipo_gestor(params[:evento_id], params[:usuario])
    render json: [@equipo_gestor, @evento_id]
  end

  def eliminar_contactos
    @equipo_gestor = EquipoGestor.find(params[:id])
    @equipo_gestor.destroy
  end

  def destroy
    if @equipo_gestor.destroy
      respond_to do |format|
        format.html { redirect_to  evento_equipo_gestor_index_path(@evento_id.id), notice: 'Equipo Gestor eliminado existosamente.' }
      end
    end
  end

  private

  def set_equipo_gestor
    @equipo_gestor = EquipoGestor.find(params[:id])
  end

  def set_evento
    @evento_id = Evento.find(params[:evento_id])
  end

  def self.permission
    :EquipoGestor
  end

end
