json.array!(@grupos) do |grupo|
  json.extract! grupo, :id, :nombre, :empresa_id
  json.url grupo_url(grupo, format: :json)
end
