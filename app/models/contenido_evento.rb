class ContenidoEvento < ActiveRecord::Base
  belongs_to :evento
  belongs_to :contenido
end
