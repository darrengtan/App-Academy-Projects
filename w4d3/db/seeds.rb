# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(username: "bob", password: "bobbob")
User.create!(username: "ryan", password: "password")
User.create!(username: "eric", password: "password")

Cat.create!(birth_date: '01-01-2015', color: 'black', name: 'felix1', sex:'M', user_id: 1)
Cat.create!(birth_date: '01-01-2014', color: 'white', name: 'felix2', sex:'F', user_id: 1)
Cat.create!(birth_date: '01-01-2013', color: 'orange', name: 'felix3', sex:'M', user_id: 2)


CatRentalRequest.create!(cat_id: 1, start_date: '01-01-2010', end_date: '01-04-2010', user_id: 2)
CatRentalRequest.create!(cat_id: 1, start_date: '01-03-2010', end_date: '01-05-2010', user_id: 3)
CatRentalRequest.create!(cat_id: 1, start_date: '01-06-2010', end_date: '01-07-2010', user_id: 3)
CatRentalRequest.create!(cat_id: 2, start_date: '01-01-2011', end_date: '01-04-2011', user_id: 3)
CatRentalRequest.create!(cat_id: 2, start_date: '01-07-2011', end_date: '01-09-2011', user_id: 3)
CatRentalRequest.create!(cat_id: 3, start_date: '01-09-2012', end_date: '01-10-2012', user_id: 3)
CatRentalRequest.create!(cat_id: 3, start_date: '01-06-2012', end_date: '01-07-2012', user_id: 1)
