class Mensaje < ActiveRecord::Base

  belongs_to :evento

  mount_uploader :archivo_adjunto, DocUploader

  validates :asunto, :descripcion,  presence: true


  def nombre_evento
    evento = Evento.find(self.evento_id).nombre
    return evento
  end

  def documentos_path
    "uploads/mensajes/"+
        "#{self.nombre_evento.gsub(" ","_").parameterize}/#{self.id}"
  end

end
