json.array!(@zonas) do |zona|
  json.extract! zona, :id, :nombre, :cupos, :precio, :num_asiento_inicial, :num_asiento_final
  json.url zona_url(zona, format: :json)
end
