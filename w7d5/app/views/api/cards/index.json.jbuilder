json.array! @cards do |card|
  json.partial! "show", card: card
end
