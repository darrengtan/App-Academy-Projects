# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

test_user = User.create(email: 'darren@aa.io', password: 'password')
test_board = Board.create(title: 'Testing Trello App', user_id: 1)
test_list = List.create(title: 'First Test List', board_id: 1, ord: 1)
test_list2 = List.create(title: 'Second Test List', board_id: 1, ord: 3)
test_list3 = List.create(title: 'Third Test List', board_id: 1, ord: 2)
test_card = Card.create(title: 'First Test Card', list_id: 1, ord: 1, description: "I like cake")
test_card = Card.create(title: 'Second Test Card', list_id: 1, ord: 3, description: "I like cats")
test_card = Card.create(title: 'Third Test Card', list_id: 1, ord: 2, description: "I like cats covered with cake")
