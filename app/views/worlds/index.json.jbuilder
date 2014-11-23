json.array!(@worlds) do |world|
  json.extract! world, :id, :code, :freeze
  json.url world_url(world, format: :json)
end
