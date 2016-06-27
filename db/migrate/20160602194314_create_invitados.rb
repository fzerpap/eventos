class CreateInvitados < ActiveRecord::Migration
  def change
    create_table :invitados do |t|
      t.datetime :fecha_invitacion
      t.datetime :fecha_confirmacion
      t.integer :tipo_confirmacion
      t.references :contacto, index: true
      t.references :evento, index: true

      t.timestamps
    end
  end
end
