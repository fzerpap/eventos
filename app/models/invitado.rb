class Invitado < ActiveRecord::Base

  belongs_to :contacto
  belongs_to :evento

  enum tipo_confirmacion: [:no_responde, :asistire, :no_asistire]

  #manejo del enum
  def self.valid_tipo_confirmacion
    %w[no_responde asistite no_asistire]
  end


  def self.formatear_filtros(evento_id, grupos, sexo, estados_civiles,  desde, hasta )
    ids_sexos = sexo.present? ?  sexo.map {|s| s.to_i} :  nil
    ids_estados_civiles = estados_civiles.present? ?  estados_civiles.map {|e| e.to_i} : nil
    ids_grupos =  grupos.present? ? grupos.map {|g| g.to_i} :  nil
    evento_id = evento_id != '' ? evento_id : nil
    desde = desde.present? ? desde.to_i : nil
    hasta = hasta.present? ? hasta.to_i : nil
    return evento_id,  ids_grupos,  ids_sexos, ids_estados_civiles, desde, hasta
  end



  def self.crear_lista(filtro)

    #parametro evento
    if filtro[0] != nil && filtro[1] == nil && filtro[2] == nil && filtro[3] == nil && filtro[4] == nil && filtro[5]== nil
      f0 = filtro[0].to_s
      c0= "eventos.id = #{f0}"
    elsif filtro[0] != nil && (filtro[1] != nil || filtro[2] != nil || filtro[3] != nil || filtro[4] != nil || filtro[5]!= nil)
      f0 = filtro[0].to_s
      c0= "eventos.id = #{f0}  AND "
    else
      c0 = ''
    end

    #parametro grupos
    if filtro[1].present? && filtro[1] != nil && filtro[0]!= nil && filtro[2] != nil && filtro[3] != nil && filtro[4] != nil && filtro[5] != nil
      f1 = filtro[1].to_s.gsub('[','').gsub(']','')
      c1= " grupos.id IN (#{f1}) AND "
      puts 'entro g1'
    elsif filtro[1].present? && filtro[1] != nil && filtro[0]!= nil && filtro[2] == nil && filtro[3] == nil && filtro[4] == nil && filtro[5] == nil
      f1 =filtro[1].to_s.gsub('[','').gsub(']','')
      c1= " grupos.id IN (#{f1}) "
      puts 'entro g2'
    elsif filtro[1].present? && filtro[1] != nil && ( filtro[0] != nil || filtro[2] != nil || filtro[3] != nil || filtro[4] != nil || filtro[5] != nil )
      f1 = filtro[1].to_s.gsub('[','').gsub(']','')
      c1= " grupos.id IN (#{f1}) AND "
      puts 'entro g3'
    elsif filtro[1].present? && filtro[1] != nil && filtro[0]== nil && filtro[2] == nil && filtro[3] == nil && filtro[4] == nil && filtro[5] == nil
      f1 = filtro[1].to_s.gsub('[','').gsub(']','')
      c1= "grupos.id IN (#{f1}) "
      puts 'entro g4'
    else
      c1 = ''
    end

    #parametro sexo
    if filtro[2].present? && filtro[2] != nil && filtro[0] != nil && filtro[1] != nil && filtro[3] != nil && filtro[4] != nil && filtro[5]!= nil
      f2 =  filtro[2].to_s.gsub('[','').gsub(']','')
      c2= " AND contactos.sexo IN (#{f2}) AND "
      puts 'entro s1'
    elsif filtro[2].present? && filtro[2] != nil && (filtro[3] != nil || filtro[4] != nil || filtro[5]!= nil)
      f2 = filtro[2].to_s.gsub('[','').gsub(']','')
      c2= " contactos.sexo IN (#{f2}) AND "
      puts 'entro s2'
    elsif filtro[2].present? && filtro[2] != nil && filtro[3] == nil && filtro[4] == nil && filtro[5]== nil
      f2 = filtro[2].to_s.gsub('[','').gsub(']','')
      c2= " contactos.sexo IN (#{f2}) "
      puts 'entro s3'
    else
      c2 = ''
    end

    #parametro estado civil
    if filtro[3].present? && filtro[3] != nil && filtro[4] != nil && filtro[5]!= nil
      f3 = filtro[3].to_s.gsub('[','').gsub(']','')
      c3= " contactos.estado_civil IN (#{f3}) AND "
    elsif filtro[3].present? &&  filtro[3] != nil && filtro[4] == nil && filtro[5]== nil
      f3 = filtro[3].to_s.gsub('[','').gsub(']','')
      c3= " contactos.estado_civil IN (#{f3}) "
    else
      c3 = ''
    end

    #parametro rango de fecha
    if filtro[4] != nil && filtro[5] != nil
      f4 = (Time.now.year - filtro[4]).to_s
      f5 = (Time.now.year - filtro[5]).to_s
      c4=  " contactos.fecha_nac <= '#{f4}-01-01'  and  contactos.fecha_nac >= '#{f5}-01-01' "
    else
      c4= ''
    end

    #construyo el sql
    p1 = c0 + c1 + c2 + c3+ c4

    sql = self.sql_invitados( p1)

    #procesa el sql
    invitados = self.find_by_sql([sql])

    #crea los invitados
    Invitado.create_invitado(invitados) ? lista = true : lista = false

    return lista


  end


  def self.sql_invitados( p1)
    <<SQL
        SELECT contactos.* , eventos.id as evento_id
        FROM contacto_grupos
          INNER JOIN contactos ON contactos.id = contacto_grupos.contacto_id
          INNER JOIN grupos ON grupos.id = contacto_grupos.grupo_id
          INNER JOIN empresas ON empresas.id = grupos.empresa_id INNER JOIN eventos ON eventos.empresa_id = empresas.id
        WHERE
          #{p1};
SQL

  end


  def self.create_invitado(invitados)
    invitados.each do |inv|
      Invitado.find_by(contacto_id: inv.id, evento_id: inv.evento_id) ||
        Invitado.create(fecha_invitacion: Time.zone.today, tipo_confirmacion: 0 , contacto_id: inv.id, evento_id: inv.evento_id)
    end
  end


  def self.formatear_doc_identidad(contacto)
    unless !contacto
      len = contacto.length
      pos = contacto.index(',') + 2
      return contacto[pos, len]
    end
  end

  def self.asociar_invitado_contacto(contactos, evento)
    contactos.each do |objeto|
      Contacto.where('doc_identidad = ?', objeto.to_s).each do |con|
        #validar si ya esta invitado
       @invitado =  Invitado.find_by(contacto_id: con.id, evento_id: evento.id) ||
            Invitado.create(fecha_invitacion: Time.zone.today, tipo_confirmacion: 0 , contacto_id: con.id, evento_id: evento.id)
      end
    end
    return @invitado.nil? ? false : true
  end


end
