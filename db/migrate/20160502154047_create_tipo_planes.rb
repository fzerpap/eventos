class CreateTipoPlanes < ActiveRecord::Migration
  def change
    create_table :tipo_planes do |t|
      t.string :nombre
      t.boolean :invitacion, default: false
      t.boolean :confirmacion, default: false
      t.boolean :inscripcion, default: false
      t.boolean :pago, default: false
      t.boolean :validar_pago, default: false
      t.boolean :baja, default: false
      t.boolean :precheck_in, default: false
      t.boolean :check_in, default: false
      t.boolean :contenido, default: false
      t.boolean :estadisticas, default: false

      t.timestamps
    end
  end
end
