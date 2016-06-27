class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :nombre, null: false
      t.text :descripcion, null: false
      t.date :fecha_inicio, null: false
      t.date :fecha_fin, null: false
      t.integer :num_invitados
      t.string :lugar
      t.string :horario
      t.text :servicios, null: false
      t.boolean :aprobacion, default: false
      t.date :fecha_limite_pago, null: false
      t.date :fecha_limite_baja, null: false
      t.decimal :porc_penalizacion

      t.references :empresa, index: true

      t.timestamps
    end
    add_index :eventos, :nombre, unique: true
  end
end
