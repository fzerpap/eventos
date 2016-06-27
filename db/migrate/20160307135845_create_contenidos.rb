class CreateContenidos < ActiveRecord::Migration
  def change
    create_table :contenidos do |t|
      t.string :titulo
      t.string :autor
      t.string :palabras_claves
      t.string :nombre_archivo
      t.text :descripcion
      t.integer :tipo_archivo
      t.references :empresa, index: true
      t.references :tipo_contenido, index: true
      t.timestamps
    end
  end
end
