json.array! @boards do |board|
  json.partial! "show", board: board
end
