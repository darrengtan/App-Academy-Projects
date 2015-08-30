json.array! @lists do |list|
  json.partial! "show", list: list
end
