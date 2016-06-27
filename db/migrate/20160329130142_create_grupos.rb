class CreateGrupos < ActiveRecord::Migration
  def change
    create_table :grupos do |t|
      t.string :nombre, null: false
      t.references :empresa, index: true
      t.timestamps
    end
  end
end
