class Contacto < ActiveRecord::Base
  belongs_to :estado
  belongs_to :profesion
  belongs_to :ministerio
  has_many :users
  has_many :inscripcion_eventos
  has_many :contacto_grupos
  has_many :contacto_empresas,  :dependent => :destroy
  accepts_nested_attributes_for :contacto_empresas
  has_many :invitados


  enum estado_civil: [:soltero, :casado, :divorciado, :viudo]
  enum sexo: [:femenino, :masculino]

  validates :nombres, :apellidos, :doc_identidad, :email, :telefono, :fecha_nac,
            :estado_id, :profesion_id, :estado_civil, :sexo, presence: true
  validates :email, uniqueness: {message:'Ya existe el e-mail ingresado. Debe ingresar su e-mail.'}
  validates_confirmation_of :email, message: 'El Email y su confirmación no coincide'
  validates :doc_identidad, uniqueness: {message:'Ya existe el nro. de documento de identidad.'}

  before_destroy :safe_to_delete

  def self.enum_sexo
    %w[femenino masculino]
  end

  def self.enum_estado_civil
    %w[soltero casado divorciado viudo]
  end


  private
    def safe_to_delete
      if self.inscripcion_eventos.any?
        return false
      end
    end

end
