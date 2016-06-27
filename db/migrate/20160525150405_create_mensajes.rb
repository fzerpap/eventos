class CreateMensajes < ActiveRecord::Migration
  def change
    create_table :mensajes do |t|
      t.string :asunto
      t.boolean :remitente, default: true
      t.string :descripcion
      t.boolean :asiento, default: false
      t.boolean :coordinador, default: true
      t.string :enlace
      t.string :archivo_adjunto
      t.references :evento, index: true

      t.timestamps
    end
  end
end
