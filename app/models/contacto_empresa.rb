class ContactoEmpresa < ActiveRecord::Base
  belongs_to :contacto
  belongs_to :empresa
end
