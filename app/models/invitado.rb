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

  def self.consulta(filtro)
    # invitados = ContactoGrupo.joins(:contacto, grupo: [:evento] ).where( "eventos.id = ? and contactos.sexo IN (?) and contactos.estado_civil IN (?) and  contactos.fecha_nac <= '?-01-01'  and  contactos.fecha_nac >= '?-01-01' and grupos.id IN (?) ",
    #                                                         filtro[0], filtro[1], filtro[2], Time.now.year - filtro[4], Time.now.year - filtro[5], filtro[3]  )

    #ContactoGrupo.joins(:contacto, grupo: [empresa: [:eventos] ]).where('eventos.id = ? and grupos.id IN (?) and contactos.sexo IN (?) and contactos.estado_civil IN (?) and  contactos.fecha_nac <= '?-01-01'  and  contactos.fecha_nac >= '?-01-01'  ',filtro[0], filtro[1], filtro[2],  filtro[3], Time.now.year - filtro[4], Time.now.year - filtro[5]).select('contactos.* , eventos.id')
    puts filtro[0].inspect
    puts filtro[1].inspect


    #parametro evento
    if filtro[0] != 0 && filtro[1] == 0 && filtro[2] == 0 && filtro[3] == 0 && filtro[4] == 0 && filtro[5]== 0
      c0= 'eventos.id = ?'
      f0 = filtro[0].to_s
    elsif filtro[0] != 0 && (filtro[1] != 0 || filtro[2] != 0 || filtro[3] != 0 || filtro[4] != 0 || filtro[5]!= 0)
      c0= 'eventos.id = ?  and '
      f0 = filtro[0].to_s + ','
    else
      c0 = ''
      f0 = ''
    end

    #parametro grupos
    if filtro[1].present? && filtro[1] != 0 && filtro[0]!= 0 && filtro[2] != 0 && filtro[3] != 0 && filtro[4] != 0 && filtro[5] != 0
      c1= ' grupos.id IN (?) and '
      f1 = filtro[1].to_s  + ','
    elsif filtro[1].present? && filtro[1] != 0 && filtro[0]!= 0 && filtro[2] == 0 && filtro[3] == 0 && filtro[4] == 0 && filtro[5] == 0
      c1= ' and grupos.id IN (?) '
      f1 =filtro[1].to_s
    elsif filtro[1].present? && filtro[1] != 0 && ( filtro[0] != 0 || filtro[2] != 0 || filtro[3] != 0 || filtro[4] != 0 || filtro[5] != 0 )
      c1= ' grupos.id IN (?) and '
      f1 = filtro[1].to_s + ','
    elsif filtro[1].present? && filtro[1] != 0 && filtro[0]== 0 && filtro[2] == 0 && filtro[3] == 0 && filtro[4] == 0 && filtro[5] == 0
      c1= 'grupos.id IN (?) '
      f1 = filtro[1].to_s
    else
      c1 = ''
      f1 = ''
    end

    #parametro sexo
    if filtro[2].present? && filtro[2] != 0 && filtro[0] != 0 && filtro[1] != 0 && filtro[3] != 0 && filtro[4] != 0 && filtro[5]!= 0
      c2= ' and contactos.sexo IN (?) and '
      f2 = ',' + filtro[2].to_s + ','
    elsif filtro[2].present? && filtro[2] != 0 &&  (filtro[0] != 0  || filtro[1] != 0 || filtro[3] == 0 || filtro[4] != 0 || filtro[5]!= 0)
      c2= ' contactos.sexo IN (?) and '
      f2 = filtro[2].to_s + ','
    elsif filtro[2].present? && filtro[2] != 0 && filtro[0] == 0 && filtro[1] == 0 && filtro[3] == 0 && filtro[4] == 0 && filtro[5]== 0
      c2= ' contactos.sexo IN (?) '
      f2 = filtro[2].to_s
    else
      c2 = ''
      f2 = ''
    end

    #parametro estado civil
    if filtro[3].present? && filtro[3] != 0 && filtro[4] != 0 && filtro[5]!= 0
      c3= ' contactos.estado_civil IN (?) and '
      f3 = filtro[3].to_s + ','
    elsif filtro[3].present? &&  filtro[3] != 0 && filtro[4] == 0 && filtro[5]== 0
      c3= ' contactos.estado_civil IN (?) '
      f3 = filtro[3].to_s
    else
      c3 = ''
      f3 = ''
    end

    #parametro rango de fecha
    if filtro[4] != 0 && filtro[5] != 0
      c4= ' contactos.fecha_nac <= "?-01-01"  and  contactos.fecha_nac >= "?-01-01"  '
      f4 = Time.now.year - filtro[4]
      f4 = f4.to_s + ','
      f5 = Time.now.year - filtro[5]
      f5 = f5.to_s
    else
      c4= ''
      f4 = ''
      f5 = ''
    end


    invitados = "ContactoGrupo.joins(:contacto, grupo: [empresa: [:eventos] ]).where('"+c0+c1+ c2+ c3+ c4+"  ',"+f0+f1+f2+f3+f4+f5+ ")"

    invitados = invitados.gsub('\"', '')

    # p invitados
    return invitados

  end



end
