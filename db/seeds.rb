# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.find_by_email("admin@test.com").nil?
  User.create(first_name: "admin", email: "admin@test.com", password: "foobar")
end
Server.find_or_create_by_name("KGS")
Server.find_or_create_by_name("Kaya")