class AddDocumentoToInscripcionEventos < ActiveRecord::Migration
  def change
    add_column :inscripcion_eventos, :documento, :string
  end
end
