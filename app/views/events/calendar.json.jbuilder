json.array!(@events) do |event|
  json.id event.id
  json.title event.title
  json.start event.start.to_s
  json.end event.end.to_s
end