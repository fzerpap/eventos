class CreateEquipoGestores < ActiveRecord::Migration
  def change
    create_table :equipo_gestores do |t|

      t.references :evento, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
