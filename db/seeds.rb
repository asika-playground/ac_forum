# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(:username => "admin", :role => "admin", :password => "12345678", :email => "admin@ac.co")
User.create(:username => "asika", :role => "admin", :password => "12345678", :email => "asika@ac.co")

Category.create(:name => "商業")
Category.create(:name => "文學")
Category.create(:name => "汪踢")
Category.create(:name => "學姊2.0")
Category.create(:name => "沒想到吧")
Category.create(:name => "大師兄嬌喘一聲倒在何金銀的懷裡")
