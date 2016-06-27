class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  add_breadcrumb 'Inicio', '/'
  #protect_from_forgery with: :exception

  include ManageDocumentHelper

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = 'Usted no esta autorizado para acceder a la página solicitada.'
    redirect_to root_path
  end

  protected
    def self.permission
      self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
    end

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    def load_permissions
      @current_permissions = current_user.roles.each do |role|
        role.permissions.collect{|i| [i.subject_class, i.action]}
      end
    end

    def set_user
      @user = User.find_by(id: ActionController::Parameters.new(id: params[:id]).permit(:id)[:id])
    end

    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :locked, :empresa_id, :cellphone, :role_id)#, rol_ids: [])
    end

    def params_id
      ActionController::Parameters.new(id: params[:id]).permit(:id)[:id]
    end

    def check_user_empresa
      if current_user.empresa_id.nil?
        redirect_to root_path, alert: 'Usted como administrador debe estar asociado a una institución para ingresar a esta página.'
      end
    end

  private
    def armar_breadcrumb
      if params[:controller] == 'eventos' && params[:action] == 'new'
        add_breadcrumb 'Nuevo Evento', new_evento_path
      elsif params[:controller] == 'eventos' && params[:action] == 'edit'
        add_breadcrumb 'Eventos', eventos_path
        add_breadcrumb 'Editar Eventos'
      elsif params[:controller] == 'eventos' && params[:action] == 'show'
        add_breadcrumb 'Eventos', eventos_path
        add_breadcrumb 'Datos del Evento'
      elsif params[:controller] == 'eventos' && params[:action] == 'index'
        add_breadcrumb 'Registros Eventos', eventos_path
      elsif params[:controller] == 'zonas' && params[:action] == 'new'
        add_breadcrumb 'Eventos', eventos_path
        add_breadcrumb 'Nueva Zona', new_evento_zona_path
      elsif params[:controller] == 'zonas' && params[:action] == 'edit'
        add_breadcrumb 'Eventos', eventos_path
        add_breadcrumb 'Zonas', evento_zonas_path(ActionController::Parameters.new(evento_id: params[:evento_id]))
        add_breadcrumb 'Editar Zona'
      elsif params[:controller] == 'zonas' && params[:action] == 'show'
        add_breadcrumb 'Eventos', eventos_path
        add_breadcrumb 'Zonas', evento_zonas_path(ActionController::Parameters.new(evento_id: params[:evento_id]))
        add_breadcrumb 'Datos de la Zona'
      elsif params[:controller] == 'zonas' && params[:action] == 'index'
        add_breadcrumb 'Eventos', eventos_path
        add_breadcrumb 'Zonas Registradas'
      elsif params[:controller] == 'equipo_gestor' && params[:action] == 'index'
        add_breadcrumb 'Eventos', eventos_path
        add_breadcrumb 'Zonas', evento_zonas_path(ActionController::Parameters.new(evento_id: params[:evento_id]))
        add_breadcrumb 'Equipo Gestor Registrado'
      elsif params[:controller] == 'equipo_gestor' && params[:action] == 'new'
        add_breadcrumb 'Eventos', eventos_path
        add_breadcrumb 'Zonas', evento_zonas_path(ActionController::Parameters.new(evento_id: params[:evento_id]))
        add_breadcrumb 'Nuevo Equipo Gestor'
      elsif params[:controller] == 'zonas' && params[:action] == 'show'
        add_breadcrumb 'Eventos', eventos_path
        add_breadcrumb 'Zonas', evento_zonas_path(ActionController::Parameters.new(evento_id: params[:evento_id]))
        add_breadcrumb 'Datos de la Zona'
      elsif params[:controller] == 'mensajes' && params[:action] == 'new'
        add_breadcrumb 'Eventos', eventos_path
        add_breadcrumb 'Zonas', evento_zonas_path(ActionController::Parameters.new(evento_id: params[:evento_id]))
        if Evento.tipo_plan_evento(params[:evento_id]) == 'Intermedio' || Evento.tipo_plan_evento( params[:evento_id]) == 'Full'
          add_breadcrumb 'Equipo Gestor', evento_equipo_gestor_index_path(ActionController::Parameters.new(evento_id: params[:evento_id]))
        end
        add_breadcrumb 'Nuevo Mensaje', new_evento_mensaje_path
      elsif params[:controller] == 'mensajes' && params[:action] == 'edit'
        add_breadcrumb 'Eventos', eventos_path
        add_breadcrumb 'Zonas', evento_zonas_path(ActionController::Parameters.new(evento_id: params[:evento_id]))
        if Evento.tipo_plan_evento(params[:evento_id]) == 'Intermedio' || Evento.tipo_plan_evento( params[:evento_id]) == 'Full'
          add_breadcrumb 'Equipo Gestor', evento_equipo_gestor_index_path(ActionController::Parameters.new(evento_id: params[:evento_id]))
        end
        add_breadcrumb 'Editar Mensajes'
      elsif params[:controller] == 'mensajes' && params[:action] == 'show'
        add_breadcrumb 'Eventos', eventos_path
        add_breadcrumb 'Zonas', evento_zonas_path(ActionController::Parameters.new(evento_id: params[:evento_id]))
        if Evento.tipo_plan_evento(params[:evento_id]) == 'Intermedio' || Evento.tipo_plan_evento( params[:evento_id]) == 'Full'
          add_breadcrumb 'Equipo Gestor', evento_equipo_gestor_index_path(ActionController::Parameters.new(evento_id: params[:evento_id]))
        end
        add_breadcrumb 'Datos del Mensaje'
      elsif params[:controller] == 'mensajes' && params[:action] == 'index'
        add_breadcrumb 'Eventos', eventos_path
        add_breadcrumb 'Zonas', evento_zonas_path(ActionController::Parameters.new(evento_id: params[:evento_id]))
        if Evento.tipo_plan_evento(params[:evento_id]) == 'Intermedio' || Evento.tipo_plan_evento( params[:evento_id]) == 'Full'
          add_breadcrumb 'Equipo Gestor', evento_equipo_gestor_index_path(ActionController::Parameters.new(evento_id: params[:evento_id]))
        end
        add_breadcrumb 'Mensajes Registrados'

      end
    end

end
