class AddTipoPlanToEventos < ActiveRecord::Migration
  def change
    add_reference :eventos, :tipo_plan, index: true
  end
end
