class EquipoGestor < ActiveRecord::Base

  belongs_to :evento
  belongs_to :user

  def self.formatear_usuario(usuario)
    unless !usuario
      pos = usuario.index(',') - 1
      return usuario[0, pos]
    end
  end

  def self.asociar_equipo_gestor(evento, usuario)
    usuario.each do |objeto|
      User.where('name = ?', objeto.to_s).each do |con|
        #validar si ya esta el usuario en el equipo
        ueq = EquipoGestor.where('user_id= ? and evento_id= ?',con.id, evento.to_i)
        if ueq.empty?
          # guardar equipo gestor
          @equipo_gestor = EquipoGestor.create( evento_id: evento.to_i, user_id: con.id )
          @equipo_gestor.save
        end
      end
    end
    return @equipo_gestor.nil? ? false : true
  end

end
