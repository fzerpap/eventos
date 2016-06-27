class CreateContenidoEventos < ActiveRecord::Migration
  def change
    create_table :contenido_eventos do |t|
      t.references :evento, index: true
      t.references :contenido, index: true
      t.timestamps
    end
  end
end
