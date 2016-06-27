class AddPagoValidadoToInscripcionEventos < ActiveRecord::Migration
  def change
    add_column :inscripcion_eventos, :pago_validado, :boolean
  end
end
