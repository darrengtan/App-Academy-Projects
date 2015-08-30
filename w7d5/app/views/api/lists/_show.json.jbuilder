json.extract! list, :id, :title, :board_id

json.cards do
  json.array! list.cards do |card|
    json.partial! "list_card", card: card
  end
end
