class Evento < ActiveRecord::Base
  belongs_to :empresa
  belongs_to :tipo_plan
  has_many :inscripcion_eventos
  has_many :contenido_eventos
  has_many :zonas
  has_many :equipo_gestores
  has_many :mensajes
  has_many :invitados

  validates :nombre, :descripcion, :fecha_inicio, :fecha_fin,  :lugar, :horario, presence: true
  validates :nombre, uniqueness: {message:'Otro evento ha sido registrado con este nombre.'}


  def self.tipo_plan_evento(evento_id)
    evento = Evento.find(evento_id)
    return evento.tipo_plan.nombre
  end


  def safe_to_delete
    if self.inscripcion_eventos.any?
      return false
    else
      return true
    end
  end
end

