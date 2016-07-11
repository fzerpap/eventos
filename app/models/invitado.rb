class Invitado < ActiveRecord::Base

  belongs_to :contacto
  belongs_to :evento


  def self.formatear_filtros(evento_id, grupos, sexo, estados_civiles,  desde, hasta )
    ids_sexos = sexo.present? ?  sexo.map {|s| s.to_i} :  0
    ids_estados_civiles = estados_civiles.present? ?  estados_civiles.map {|e| e.to_i} : 0
    ids_grupos =  grupos.present? ? grupos.map {|g| g.to_i} :  0
    empresa_id = evento_id != '' ? Evento.find(evento_id).empresa_id : 0
    return empresa_id,  ids_grupos,  ids_sexos, ids_estados_civiles, desde.to_i, hasta.to_i
  end

  def self.grupos(filtro)
    ContactoGrupo.joins(:contacto, :grupo).where('grupos.id IN (?)', filtro[1])
  end

  def self.sexo(filtro)
    ContactoGrupo.joins(:contacto).where('sexo IN (?)', filtro[2])
  end

  def estados(filtro)
    ContactoGrupo.joins(:contacto).where('estado_civil IN (?)', filtro[3])
  end

  def self.fechas(filtro)
    ContactoGrupo.joins(:contacto).where("contactos.fecha_nac <= '?-01-01'  and  contactos.fecha_nac >= '?-01-01' ", Time.now.year - filtro[4], Time.now.year - filtro[5])
  end

  def self.consulta(filtro)

    #ContactoGrupo.joins(:contacto, grupo: [empresa: [:eventos] ]).where('eventos.id = ? and grupos.id IN (?) and contactos.sexo IN (?)
    # and contactos.estado_civil IN (?) and  contactos.fecha_nac <= '?-01-01'  and  contactos.fecha_nac >= '?-01-01'  ',filtro[0], filtro[1], filtro[2],  filtro[3], Time.now.year - filtro[4], Time.now.year - filtro[5]).select('contactos.* , eventos.id')


  end

end
