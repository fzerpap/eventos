class Invitado < ActiveRecord::Base

  belongs_to :contacto
  belongs_to :evento


  def self.formatear_filtros(evento_id, grupos, sexo, estados_civiles,  desde, hasta )
    ids_sexos = sexo.present? ?  sexo.map {|s| s.to_i} :  0
    ids_estados_civiles = estados_civiles.present? ?  estados_civiles.map {|e| e.to_i} : 0
    ids_grupos =  grupos.present? ? grupos.map {|g| g.to_i} :  0
    evento_id = evento_id != '' ? evento_id : 0
    return evento_id,  ids_grupos,  ids_sexos, ids_estados_civiles, desde.to_i, hasta.to_i
  end



  def self.crear_lista(filtro)
    #ContactoGrupo.joins(:contacto, grupo: [empresa: [:eventos] ]).where('eventos.id = ? and grupos.id IN (?) and contactos.sexo IN (?)
    # and contactos.estado_civil IN (?) and  contactos.fecha_nac <= '?-01-01'  and  contactos.fecha_nac >= '?-01-01'  ',filtro[0], filtro[1], filtro[2],  filtro[3], Time.now.year - filtro[4], Time.now.year - filtro[5]).select('contactos.* , eventos.id')

    #consulta con parametros
    if filtro[0] != 0 && filtro[1] == 0 && filtro[2] == 0 && filtro[3] == 0 && filtro[4] == 0 && filtro[5]== 0
      invitados = ContactoGrupo.joins(:contacto, grupo: [empresa: [:eventos] ]).where('eventos.id = ? ',filtro[0]).select('contactos.* , eventos.id')
    elsif filtro[0] != 0 && filtro[1] != 0 && filtro[2] == 0 && filtro[3] == 0 && filtro[4] == 0 && filtro[5]== 0
      invitados = ContactoGrupo.joins(:contacto, grupo: [empresa: [:eventos] ]).where('eventos.id = ? and grupos.id IN (?)',filtro[0], filtro[1]).select('contactos.* , eventos.id')
    elsif filtro[0] != 0 && filtro[1] != 0 && filtro[2] != 0 && filtro[3] == 0 && filtro[4] == 0 && filtro[5]== 0
      invitados = ContactoGrupo.joins(:contacto, grupo: [empresa: [:eventos] ]).where('eventos.id = ? and grupos.id IN (?) and contactos.sexo IN (?)',filtro[0], filtro[1], filtro[2]).select('contactos.* , eventos.id')
    elsif filtro[0] != 0 && filtro[1] != 0 && filtro[2] != 0 && filtro[3] != 0 && filtro[4] == 0 && filtro[5]== 0
      invitados = ContactoGrupo.joins(:contacto, grupo: [empresa: [:eventos] ]).where('eventos.id = ? and grupos.id IN (?) and contactos.sexo IN (?) and contactos.estado_civil IN (?)',filtro[0], filtro[1], filtro[2], filtro[3]).select('contactos.* , eventos.id')
    elsif filtro[0] != 0 && filtro[1] != 0 && filtro[2] != 0 && filtro[3] != 0 && filtro[4] != 0 && filtro[5]!= 0
      invitados = ContactoGrupo.joins(:contacto, grupo: [empresa: [:eventos] ]).where("eventos.id = ? and grupos.id IN (?) and contactos.sexo IN (?) and contactos.estado_civil IN (?) and  contactos.fecha_nac <= '?-01-01'  and  contactos.fecha_nac >= '?-01-01' ",filtro[0], filtro[1], filtro[2], filtro[3],Time.now.year - filtro[4], Time.now.year - filtro[5] ).select('contactos.* , eventos.id')
    elsif filtro[4] == 0 && filtro[5]== 0
      invitados = ContactoGrupo.joins(:contacto, grupo: [empresa: [:eventos] ]).where("eventos.id = ? and grupos.id IN (?) and contactos.sexo IN (?) and contactos.estado_civil IN (?)  ",filtro[0], filtro[1], filtro[2], filtro[3] ).select('contactos.* , eventos.id')
    else
      invitados = ContactoGrupo.joins(:contacto, grupo: [empresa: [:eventos] ]).where("eventos.id = ? and grupos.id IN (?) and contactos.sexo IN (?) and contactos.estado_civil IN (?) and  contactos.fecha_nac <= '?-01-01'  and  contactos.fecha_nac >= '?-01-01' ",filtro[0], filtro[1], filtro[2], filtro[3],Time.now.year - filtro[4], Time.now.year - filtro[5] ).select('contactos.* , eventos.id')
    end
    puts invitados.inspect
    #crea lista
    # if invitados.empty?
    #   invitados = 0
    # else
    #   invitados.each {|invitado| Invitado.new(fecha_invitacion: invitado, fecha_confirmacion: ,tipo_confirmacion: ,contacto_id: , evento_id: ) }
    # end





  end

end
