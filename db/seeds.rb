# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Firm.create({:name => 'Huslab', :corporate_id => '1234567-8', :account_number => '12345678', :resource_type =>'Huslab'})
User.create({:name =>'Riku', :email=>'riku@hus.fi'})
