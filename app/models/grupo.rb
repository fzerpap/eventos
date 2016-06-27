class Grupo < ActiveRecord::Base
  #asociaciones
  belongs_to :empresa
  has_many :contacto_grupos,  :dependent => :destroy
  accepts_nested_attributes_for :contacto_grupos

  validates :nombre, uniqueness:{message:'Otro Grupo ha sido registrado con este nombre.'},
           presence: { message: 'El campo nombre es obligatorio'}

  def self.formatear_doc_identidad(contacto)
    unless !contacto
      len = contacto.length
      pos = contacto.index(',') + 2
      return contacto[pos, len]
    end
  end

  def self.asociar_grupo_contacto(grupo, contacto)
    grupo = Grupo.find_by_nombre(grupo)

    contacto.each do |objeto|
      Contacto.where('doc_identidad = ?', objeto.to_s).each do |con|
        #validar si ya esta en contacto_grupo
        cg = ContactoGrupo.where('contacto_id= ? and grupo_id= ?',con.id, grupo.id)
        if cg.empty?
          # guardar contacto_grupo
          @contacto_grupo = ContactoGrupo.create( grupo_id: grupo.id, contacto_id: con.id )
          @contacto_grupo.save
        end
      end
    end
    return @contacto_grupo.nil? ? false : true
  end

end
