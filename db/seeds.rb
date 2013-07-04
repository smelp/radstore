# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)


User.create(:name =>'Riku', :email =>'riku@hus.fi', :password =>'123456',:password_confirmation =>'123456',:admin => 't')

User.create(:name =>'Matti', :email =>'matti@hus.fi', :password =>'123456',:password_confirmation =>'123456')

