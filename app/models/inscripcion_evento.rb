class InscripcionEvento < ActiveRecord::Base

  belongs_to :contacto
  belongs_to :evento


  validates :documento , presence: {message: 'El campo documento es obligatorio'}, on: :update
  validates :nro_pago, presence: {message: 'El campo documento es obligatorio'}, :on => :update
  validates :nro_pago, uniqueness: {message: 'El campo número de pago ya está registrado'}, :on => :update


  mount_uploader :documento, ImgDocUploader

  def self.get_estadisticas(evento)
    estadisticas = Array.new
    inscritos = where(evento_id: evento.id)
    estadisticas << inscritos.where(aceptado: true).count
    estadisticas << inscritos.where(aceptado: false).count
    estadisticas << inscritos.where(aceptado: nil).count
    return estadisticas
  end

  def self.get_estadisticas_xcriterio(evento_id,pais_id,criterio)
    inscritos = where(evento_id: evento_id )

    select_sum = "count(*) as total,sum(case aceptado when true then 1 else 0 end) as aceptados,
             sum(case aceptado when false then 1 else 0 end) as rechazados"

    if criterio == 'estado'
      select = "estados.nombre, "+select_sum
      estadisticas = inscritos.joins(contacto: :estado)
      .select(select).where("estado_id > 0").group("estados.nombre")
      .collect{|i| {criterio: i.nombre,
                   total: i.total,aceptados: i.aceptados,rechazados: i.rechazados,por_aprobar: i.total-i.aceptados-i.rechazados  } }
    elsif criterio == 'ministerio'
        select = "ministerios.nombre, "+select_sum
        estadisticas = inscritos.joins(contacto: :ministerio)
        .select(select).group("ministerios.nombre")
        .collect{|i| {criterio: i.nombre,
                      total: i.total,aceptados: i.aceptados,rechazados: i.rechazados,por_aprobar: i.total-i.aceptados-i.rechazados  } }
    else
      select = "profesiones.nombre, "+select_sum
      estadisticas = inscritos.joins(contacto: :profesion)
      .select(select).group("profesiones.nombre")
      .collect{|i| {criterio: i.nombre,
                    total: i.total,aceptados: i.aceptados,rechazados: i.rechazados,por_aprobar: i.total-i.aceptados-i.rechazados  } }
    end
    return estadisticas
  end

  def self.get_estadisticas_pagos(evento)
    estadisticas = Array.new
    pagos = where(evento_id: evento.id)
    estadisticas << pagos.where(pago_validado: true).count
    estadisticas << pagos.where(pago_validado: false).count
    estadisticas << pagos.sum(:monto)

    return estadisticas
  end

  def nombre_evento
    evento = Evento.find(self.evento_id).nombre
    return evento
  end

  def depositos_path
    "uploads/depositos/"+
        "#{self.nombre_evento.gsub(" ","_").parameterize}/#{self.id}"
  end
end
