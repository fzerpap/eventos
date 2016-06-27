# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
  # inflect.acronym 'RESTful'
  inflect.clear

  inflect.plural(/$/, 's')
  inflect.plural(/([^aeéiou])$/i, '\1es')
  inflect.plural(/([aeiou]s)$/i, '\1')
  inflect.plural(/z$/i, 'ces')
  inflect.plural(/á([sn])$/i, 'a\1es')
  inflect.plural(/é([sn])$/i, 'e\1es')
  inflect.plural(/í([sn])$/i, 'i\1es')
  inflect.plural(/ó([sn])$/i, 'o\1es')
  inflect.plural(/ú([sn])$/i, 'u\1es')

  inflect.singular(/s$/, '')
  inflect.singular(/es$/, '')

  inflect.irregular('el', 'los')
end

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'pais', 'paises'
  inflect.plural  'paises', 'pais'
  inflect.irregular 'Pais', 'Paises'
  inflect.plural 'Paises', 'Pais'

  inflect.irregular 'permission', 'permissions'
  inflect.plural  'permissions', 'permission'

  inflect.irregular 'user', 'users'
  inflect.plural  'users', 'user'
  inflect.irregular 'User', 'Users'
  inflect.plural 'Users', 'User'

  inflect.irregular 'Empresa', 'Empresas'
  inflect.plural 'Empresas', 'Empresa'
  inflect.irregular 'empresa', 'empresas'
  inflect.plural  'empresas', 'empresa'

  inflect.irregular 'InscripcionEvento', 'InscripcionEventos'
  inflect.plural 'InscripcionEventos', 'InscripcionEvento'
  inflect.irregular 'inscripcion_evento', 'inscripcion_eventos'
  inflect.plural  'inscripcion_eventos', 'inscripcion_evento'

  inflect.irregular 'Contacto', 'Contactos'
  inflect.plural 'Contactos', 'Contacto'
  inflect.irregular 'contacto', 'contactos'
  inflect.plural  'contactos', 'contacto'

  inflect.irregular 'Contenido', 'Contenidos'
  inflect.plural 'Contenidos', 'Contenido'
  inflect.irregular 'contenido', 'contenidos'
  inflect.plural  'contenidos', 'contenido'

  inflect.irregular 'Grupo', 'Grupos'
  inflect.plural 'Grupos', 'Grupo'
  inflect.irregular 'grupo', 'grupos'
  inflect.plural  'grupos', 'grupo'

  inflect.irregular 'EquipoGestor', 'EquipoGestores'
  inflect.plural 'EquipoGestores', 'EquipoGestor'
  inflect.irregular 'equipo_gestor', 'equipo_gestores'
  inflect.plural  'equipo_gestores', 'equipo_gestor'

  inflect.irregular 'Role', 'Roles'
  inflect.plural  'Roles', 'Role'
  inflect.irregular 'role', 'roles'
  inflect.plural  'roles', 'role'

  inflect.irregular 'TipoPlan', 'TipoPlanes'
  inflect.plural  'TipoPlanes', 'TipoPlan'
  inflect.irregular 'tipo_plan', 'tipo_planes'
  inflect.plural  'tipo_planes', 'tipo_plan'

  inflect.irregular 'Zona', 'Zonas'
  inflect.plural  'Zonas', 'Zona'
  inflect.irregular 'zona', 'zonas'
  inflect.plural  'zonas', 'zona'

  inflect.irregular 'Mensaje', 'Mensajes'
  inflect.plural  'Mensajes', 'Mensaje'
  inflect.irregular 'mensaje', 'mensajes'
  inflect.plural  'mensajes', 'mensaje'

  inflect.irregular 'Invitado', 'Invitados'
  inflect.plural  'Invitados', 'Invitado'
  inflect.irregular 'invitado', 'invitados'
  inflect.plural  'invitados', 'invitado'

end
