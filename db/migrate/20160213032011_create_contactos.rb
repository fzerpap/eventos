class CreateContactos < ActiveRecord::Migration
  def change
    create_table :contactos do |t|
      t.string :nombres
      t.string :apellidos
      t.string :doc_identidad
      t.date :fecha_nac
      t.string :email
      t.string :telefono
      t.string :hijos
      t.integer :estado_civil
      t.integer :sexo

      t.references :estado, index: true
      t.references :profesion, index: true
      t.references :ministerio, index: true

      t.timestamps
    end
  end
end
