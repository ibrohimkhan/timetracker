# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


unless User.any?

  5.times do |i|
	  User.create([{
	  	first_name: "FirstName#{i}",
	  	last_name:  "LastName#{i}",
	  	email:      "test#{i}@test.ru",
	  	password:   "test1234"
	  }])
  end

end