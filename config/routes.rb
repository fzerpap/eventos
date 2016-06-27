Eventos::Application.routes.draw do

  resources :invitados
  post 'crear_listas_invitados', to: 'invitados#crear_listas_invitados'

  resources :tipo_planes

  resources :contenidos
  get 'Contenido/Eventos', to: 'contenidos#index_contenido_eventos', as: :index_contenido_eventos
  post 'buscar/contenido_eventos',    to: 'contenidos#buscar_contenido_eventos'


  get 'pago_eventos/index'

  get 'pago_eventos/registro_pago'

  get 'pago_eventos/validar_pago'

  resources :contactos

  get 'new_contacto/:id_empresa/:id_evento/', to: 'contactos#new_contacto',  as: :nuevo_contacto
  post 'create_contacto', to: 'contactos#create_contacto'
  patch 'update_contacto', to: 'contactos#update_contacto'
  get 'show_contacto/:id/:em', to: 'contactos#show_contacto', as: :show_contacto
  get 'edit_contacto', to: 'contactos#edit_contacto'


  # resources :eventos
  post 'plan',  to: 'eventos#verificar_plan',  as: :verificar_plan,  defaults: { format: :json }


  resources :eventos do
    resources :zonas
    resources :mensajes
    resources :equipo_gestor do
      get :autocomplete_usuarios_roles, :on => :collection
    end

  end

  #equipo gestor
  post 'agregar_equipo',  to: 'equipo_gestor#agregar_equipo',  as: :agregar_equipo,  defaults: { format: :json }
  post 'guardar_equipo',  to: 'equipo_gestor#guardar_equipo_gestor',  as: :guardar_equipo


  resources :empresas

  resources :grupos do
    get :autocomplete_contacto_nombres, :on => :collection
  end

  post 'agregar_contacto',  to: 'grupos#agregar_contactos',  as: :agregar_contactos,  defaults: { format: :json }
  post 'asociar_contacto',  to: 'grupos#asociar_grupo_contactos',  as: :asociar_contactos
  delete 'delete_contacto', to: 'grupos#eliminar_contactos', as: :delete_contactos

 # You can have the root of your site routed with "root"
  root to: 'static#index'


  devise_for :users, controllers: {
    passwords: 'users/passwords',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :inscripcion_eventos
  get  'visualizar_inscritos',   to: 'inscripcion_eventos#ver_inscripciones',         as: :ver_inscritos
  post 'aprobar_preinscritos',   to: 'inscripcion_eventos#aprobar_preinscritos',      as: :aprobar_preinscritos
  get  'estadisticas_inscritos', to: 'inscripcion_eventos#estadisticas_inscripciones',as: :estadisticas_inscritos
  post 'procesar_estadisticas',  to: 'inscripcion_eventos#procesar_estadisticas',     as: :procesar_estadisticas
  get  'inscripcion',   to: 'inscripcion_eventos#index_consulta_eventos',         as: :inscripcion

  get  'pago_eventos',   to: 'pago_eventos#index',        as: :pago_eventos
  get  'registro_ofrenda',   to: 'pago_eventos#registro_pago',as: :registro_ofrenda
  get  'validar_pago_evento',    to: 'pago_eventos#validar_pago',  as: :validar_pago_evento
  patch  'obtener_inscrito_evento',to: 'pago_eventos#obtener_inscrito_evento',  as: :obtener_inscrito_evento
  patch  'update_pago',to: 'pago_eventos#update_pago',  as: :update_pago


  devise_scope :user do
    get 'users/new', to: 'users/registrations#new_user'
    post 'users/create_user',
         to: 'users/registrations#create_user'
    get 'user/show/:id', to: 'users/registrations#show', as: :user_show
    get 'users/index', to: 'users/registrations#index'
    get 'users/edit_user/:id', to: 'users/registrations#edit_user', as: :user_edit_user
    post 'users/update_user', to: 'users/registrations#update_user'
    delete 'users/delete_user/:id', to: 'users/registrations#delete_user', as: :user_delete_user
    get 'profile', to: 'users/profiles#profile'
    get 'profile/edit', to: 'users/profiles#edit'
    post 'profile/update', to: 'users/profiles#update'

    get 'ajustes', to: 'users/settings#index', as: :settings
    post 'save_subcuenca', to: 'users/settings#save_subcuenca'
  end

  scope module: 'users' do
    resources :client_users
  end

  resources :roles

  #TODO clean this
  #------------------JJ-don't touch this (8) MC HAMMER------------------------------
  resources :paises, except: :show

  resources :jquery_file_uploads, only: [:create, :destroy, :index] do
    member do
      delete 'wf_destroy_no_paginado'
    end
  end
 #-----------------------------------------------------------------------


  # Dynamic Selects y Controladores Dinamicos
  namespace :dynamic_select do
    post 'dynamic_pais', to: 'dynamic_pais#codigo_pais'
    post 'dynamic_estado', to: 'dynamic_pais#estado'  end


end
