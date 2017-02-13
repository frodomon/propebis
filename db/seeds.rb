# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name:'PROPEBIS', email: 'administracion@propebis.com', username: 'admin', password: 'propebis', password_confirmation: 'propebis', roles_mask: 1)
Setting.create(expiration_alert: 30)