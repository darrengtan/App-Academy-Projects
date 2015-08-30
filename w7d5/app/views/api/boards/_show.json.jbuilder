json.extract! board, :id, :title

json.lists do
  json.array! board.lists do |list|
    json.partial! "board_list", list: list
  end
end

json.cards do
  json.array! board.cards do |card|
    json.partial! "board_card", card: card
  end
end
