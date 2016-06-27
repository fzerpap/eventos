json.array!(@contenidos) do |contenido|
  json.extract! contenido, :id
  json.url contenido_url(contenido, format: :json)
end
