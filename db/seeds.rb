

# CREANDO IDIOMAS
Idioma.delete_all
es = Idioma.create!(nombre: 'Español')
en = Idioma.create!(nombre: 'Inglés')
port = Idioma.create!(nombre: 'Portugués')
puts '#---- Idiomas  SEEDED ----#'

# CREANDO PAISES
Pais.delete_all
Pais.create!(nombre: 'Venezuela', idioma: es, codigo: '+58')
Pais.create!(nombre: 'Colombia', idioma: en, codigo: '+57')
Pais.create!(nombre: 'Brasil',idioma: port, codigo: '+55')
Pais.create!(nombre: 'Ecuador',idioma: es, codigo: '+593')
Pais.create!(nombre: 'Perú',idioma: es, codigo: '+51')
Pais.create!(nombre: 'Bolivia',idioma: es, codigo: '+591')
Pais.create!(nombre: 'Chile',idioma: es, codigo: '+56')
Pais.create!(nombre: 'Argentina',idioma: es, codigo: '+54')
Pais.create!(nombre: 'Uruguay',idioma: es, codigo: '+598')
Pais.create!(nombre: 'Paraguay',idioma: es, codigo: '+595')
Pais.create!(nombre: 'Panamá',idioma: es, codigo: '+507')
Pais.create!(nombre: 'Guatemala',idioma: es, codigo: '+502')
Pais.create!(nombre: 'El Salvador',idioma: es, codigo: '+503')
Pais.create!(nombre: 'Estados Unidos',idioma: en, codigo: '+1')
Pais.create!(nombre: 'Costa Rica',idioma: es, codigo: '+506')
Pais.create!(nombre: 'México',idioma: es, codigo: '+52')
Pais.create!(nombre: 'Curacao',idioma: es, codigo: '+5999')
puts '#---- Paises  SEEDED ----#'


# CREANDO LOS MINISTERIOS
Ministerio.delete_all
Ministerio.create!(nombre: 'Apostol' )
Ministerio.create!(nombre: 'Pastor' )
Ministerio.create!(nombre: 'Profeta' )
Ministerio.create!(nombre: 'Evangelista' )
Ministerio.create!(nombre: 'Maestro' )
Ministerio.create!(nombre: 'Servidor' )
Ministerio.create!(nombre: 'Músico-Levita' )
Ministerio.create!(nombre: 'Ninguno' )
puts '#---- Ministerio  SEEDED  FINALIZADA----#'

# CREANDO LAS PROFESIONES
Profesion.delete_all
Profesion.create!(nombre: 'Administrador' )
Profesion.create!(nombre: 'Contador' )
Profesion.create!(nombre: 'Maestro' )
Profesion.create!(nombre: 'Profesor' )
Profesion.create!(nombre: 'Músico' )
Profesion.create!(nombre: 'Economista' )
Profesion.create!(nombre: 'Ingeniero' )
Profesion.create!(nombre: 'Científico' )
Profesion.create!(nombre: 'Militar' )
Profesion.create!(nombre: 'Político' )
Profesion.create!(nombre: 'Abogado' )
Profesion.create!(nombre: 'Técnico Superior Universitario' )
Profesion.create!(nombre: 'Técnico Medio (Albañil-Mecánico-Carpintero-Otro' )
Profesion.create!(nombre: 'Médico' )
Profesion.create!(nombre: 'Enfermero(a)' )
Profesion.create!(nombre: 'Bionanálista' )
Profesion.create!(nombre: 'Farmacéutico' )
Profesion.create!(nombre: 'Comerciante' )
Profesion.create!(nombre: 'Constructor' )
Profesion.create!(nombre: 'Arquitecto' )
Profesion.create!(nombre: 'Informático' )
Profesion.create!(nombre: 'Deportista' )
Profesion.create!(nombre: 'Piloto' )
Profesion.create!(nombre: 'Agricultor' )
Profesion.create!(nombre: 'Ganadero' )
Profesion.create!(nombre: 'Empresario' )
Profesion.create!(nombre: 'Transportista' )
Profesion.create!(nombre: 'Policía' )
Profesion.create!(nombre: 'Chef de cocina' )
Profesion.create!(nombre: 'Inversionista' )
Profesion.create!(nombre: 'Estudiante' )
Profesion.create!(nombre: 'Ama de casa' )
Profesion.create!(nombre: 'Ministro Cristiano' )
Profesion.create!(nombre: 'Consejero' )
Profesion.create!(nombre: 'Ninguna' )

puts '#---- Profesión  SEEDED  FINALIZADA----#'

# CREANDO LOS ESTADOS
Estado.delete_all
Estado.create!(nombre: 'Aragua',codificacion: "AG",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Amazonas',codificacion: "AS",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Anzoategui',codificacion: "AT",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Apure',codificacion: "AP",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Barinas',codificacion: "BS",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Bolivar',codificacion: "BR",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Carabobo',codificacion: "CB",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Cojedes',codificacion: "CS",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Delta Amacuro',codificacion: "CB",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Distrito Capital',codificacion: "DC",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Falcon',codificacion: "FN",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Guarico',codificacion: "GC",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Lara',codificacion: "LR",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Mérida',codificacion: "MD",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Miranda',codificacion: "MI",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Monagas',codificacion: "MG",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Nueva Esparta',codificacion: "MG",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Portuguesa',codificacion: "PS",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Sucre',codificacion: "SR",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Táchira',codificacion: "TR",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Trujillo',codificacion: "TL",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Vargas',codificacion: "VA",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Yaracuy',codificacion: "YY",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Zulia',codificacion: "ZL",pais: Pais.where(nombre: 'Venezuela').first )
Estado.create!(nombre: 'Buenos Aires',codificacion: "BA",pais: Pais.where(nombre: 'Argentina').first )
Estado.create!(nombre: 'Ciudad de Panama',codificacion: "BA",pais: Pais.where(nombre: 'Panamá').first )

puts '#---- Estados  SEEDED  FINALIZADA----#'


# CREANDO LA EMPRESA
Empresa.delete_all
Empresa.create!(denominacion: 'Biosoft C.A',
                abreviado: 'Biosoft',rif: 'J-31665587-1', direccion_fiscal: 'Merida',
                telefono: '0416-7777777', estado: Estado.where(nombre: "Mérida").first,
                nombre_rl: 'Francisco Zerpa', email_rl: 'fzerpap@gmail.com',
                telefono_rl:  '0414-7777777')

puts '#---- Empresa  SEEDED  FINALIZADA----#'

# CREANDO LOS ROLES
Role.delete_all
admin_sistema = Role.create!(name: 'Super Usuario',
                             permissions: Permission.where(name: 'manage', subject_class: [:Static,
                                                                                           :User,
                                                                                           :Pais,
                                                                                           :Empresa,
                                                                                           :TipoPlan,
                                                                                           :jquery_file_uploads,
                                                                                           :Role]),
                             role_type: Role.role_types[:administrador_sistema])

admin_cliente = Role.create!(name: 'Administrador en la Empresa',
                             permissions: Permission.where(name: 'manage', subject_class: [:client_users,
                                                                                           :Evento,
                                                                                           :Contacto,
                                                                                           :Static,
                                                                                           :jquery_file_uploads,
                                                                                           :Grupo,
                                                                                           :Invitado,
                                                                                           :InscripcionEvento,
                                                                                           :pago_eventos,
                                                                                           :EquipoGestor,
                                                                                           :Contenido,
                                                                                           :Zona,
                                                                                           :Mensaje

                                                                         ]),
                             role_type: Role.role_types[:administrador_cliente])

administrador = Role.create!(name: 'Gerente de Eventos',
                             permissions: Permission.where(name: 'manage'),
                             role_type: Role.role_types[:cliente])


coordinador = Role.create!(name: 'Coordinador de Eventos',  permissions: Permission.where(name: 'manage'),
                           role_type: Role.role_types[:cliente])

aprobador = Role.create!(name: 'Aprobador de Participantes',  permissions: Permission.where(name: 'manage'),
                         role_type: Role.role_types[:cliente])

validador = Role.create!(name: 'Validador de Pagos',   permissions: Permission.where(name: 'manage'),
                         role_type: Role.role_types[:cliente])

gestor = Role.create!(name: 'Gestor de Check In',  permissions: Permission.where(name: 'manage'),
                      role_type: Role.role_types[:cliente])

puts '#---- Roles  SEEDED  FINALIZADA----#'

# CREANDO EL SUPER USUARIO DEL SISTEMA y USUARIO DE EMPRESA
User.delete_all
User.create!(email: 'atencion@biosoftca.com',
             username: 'super_user',
             password: '12345678',
             name: 'Super Usuario',
             cellphone: '0414-7163143',
             role: Role.where(name: 'Super Usuario').first,
             avatar: '')
User.create!(email: 'fzerpap@gmail.com',
             username: 'fzerpa',
             password: '12345678',
             name: 'Francisco Zerpa',
             cellphone: '0416-7163143',
             role: Role.where(name: 'Administrador en la Empresa').first,
             empresa: Empresa.where(abreviado: "Biosoft").first,
             avatar: '')
puts '#---- Usuarios  SEEDED  FINALIZADA----#'