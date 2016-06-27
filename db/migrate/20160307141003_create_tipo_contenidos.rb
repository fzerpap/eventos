class CreateTipoContenidos < ActiveRecord::Migration
  def change
    create_table :tipo_contenidos do |t|
      t.string :nombre
      t.references :empresa, index: true

      t.timestamps
    end
  end
end
