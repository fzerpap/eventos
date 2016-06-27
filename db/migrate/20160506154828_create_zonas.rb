class CreateZonas < ActiveRecord::Migration
  def change
    create_table :zonas do |t|
      t.string :nombre, null: false
      t.integer :cupos
      t.decimal :precio
      t.string :num_asiento_inicial, null: false
      t.string :num_asiento_final, null: false

      t.references :evento, index: true

      t.timestamps
    end
  end
end
