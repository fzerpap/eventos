json.array!(@tipo_planes) do |tipo_plan|
  json.extract! tipo_plan, :id, :nombre, :num_invitaciones, :invitacion,, :confirmacion,, :inscripcion,, :pago,, :validar_pago,, :check_in,, :contenido,, :estadisticas
  json.url tipo_plan_url(tipo_plan, format: :json)
end
