json.array!(@invitados) do |invitado|
  json.extract! invitado, :id, :fecha_invitacion, :fecha_confirmacion, :tipo_confirmacion, :contactos_id, :eventos_id
  json.url invitado_url(invitado, format: :json)
end
