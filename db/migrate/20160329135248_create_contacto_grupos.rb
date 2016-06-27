class CreateContactoGrupos < ActiveRecord::Migration
  def change
    create_table :contacto_grupos do |t|
      t.references :grupo, index: true
      t.references :contacto, index: true
      t.timestamps
    end
  end
end
