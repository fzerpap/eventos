class Contenido < ActiveRecord::Base
  # mount_uploader :nombre_archivo, VideosUploader

  belongs_to :empresa
  belongs_to :tipo_contenido
  has_many :contenido_eventos, :dependent => :destroy
  accepts_nested_attributes_for :contenido_eventos

  enum tipo_archivo: [:texto, :sonido, :video]

  validates :titulo , presence: {message: 'El campo Nombre es obligatorio'}
  validates :nombre_archivo , presence: {message: 'El campo Archivo es obligatorio'}
  validates :tipo_archivo, presence: {message: 'El campo Tipo de archivo es obligatorio'}
  validates :palabras_claves, presence: {message: 'El campo Tipo de archivo es obligatorio'}
  #manejo del enum

  def self.valid_tipo_archivo
    %w[texto sonido video]
  end

  def nombre_evento
    evento = Evento.find(self.contenido_eventos.find_by(contenido_id: self.id).evento_id).nombre
    return evento
  end


  def archivo_path
    "uploads/"+
        "#{self.empresa.denominacion.gsub(" ","_")}/"+
        "#{self.nombre_evento.gsub(" ","_")}/#{self.id}"
  end

  def self.buscar_contenido(evento_id)
    contenido_eventos = ContenidoEvento.where(evento_id: evento_id).includes(:contenido).collect{|i|
      {
          titulo: i.contenido.titulo,
          autor: i.contenido.autor,
          tipo_contenido: i.contenido.tipo_contenido.nombre,
          tipo_archivo: i.contenido.tipo_archivo,
          nombre_archivo: i.contenido.nombre_archivo
      }

    }
    return contenido_eventos
  end

end
