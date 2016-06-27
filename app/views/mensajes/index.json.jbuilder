json.array!(@mensajes) do |mensaje|
  json.extract! mensaje, :id, :asunto, :remitente, :descripcion, :asiento, :coordinador, :enlace, :archivo_adjunto, :evento_id
  json.url mensaje_url(mensaje, format: :json)
end
