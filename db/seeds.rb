# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.where(:username => 'benhamin_harrison').first_or_create
user.password = 'password'

role = Role.where(:name => 'charity registrar').first_or_create

user.roles.push role
user.save
