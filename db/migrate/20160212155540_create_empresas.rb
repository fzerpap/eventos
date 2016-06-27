class CreateEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.string :denominacion, null: false
      t.string :abreviado, null: false
      t.string :rif, null: false
      t.string :direccion_fiscal, null: false
      t.string :telefono, null: false
      t.string :nombre_rl, null: false
      t.string :email_rl, null: false
      t.boolean :es_iglesia, default: false
      t.string :telefono_rl, null: false
      t.references :estado, index: true

      t.timestamps
    end
    add_index :empresas, :denominacion, unique: true
    add_index :empresas, :abreviado, unique: true
    add_index :empresas, :rif, unique: true
  end
end
