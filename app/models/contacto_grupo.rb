class ContactoGrupo < ActiveRecord::Base
  #asociaciones
  belongs_to :grupo
  belongs_to :contacto

end
