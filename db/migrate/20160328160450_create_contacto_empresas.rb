class CreateContactoEmpresas < ActiveRecord::Migration
  def change
    create_table :contacto_empresas do |t|
      t.boolean :es_miembro, default: false
      t.references :empresa, index: true
      t.references :contacto, index: true
      t.timestamps
    end
  end
end
