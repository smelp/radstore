# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)


huslab = Firm.create(:name => 'HUSLAB', :corporate_id =>'1234567-8', :location=>'Helsinki', :address=>'Helsingintie 1', :account_number =>'11111-11111', :resource_type=>'Huslab', :resource_id=>1)

Huslab.create(:description => 'Labra', :firm => huslab)

User.create(:name =>'Riku', :email =>'riku@hus.fi', :password =>'123456',:password_confirmation =>'123456',:admin => 't',:primary_firm_id => 1)

User.create(:name =>'Matti', :email =>'matti@hus.fi', :password =>'123456',:password_confirmation =>'123456',:primary_firm_id => 1)

Storagelocation.create(:name => 'Varastopaikka 1', :huslab_id => 1)
Storagelocation.create(:name => 'Varastopaikka 2', :huslab_id => 1)

s1 = Substance.create(:genericName => 'Ryynit', :huslab_id=>1, :substanceType => 'Generaattori')
s2 = Substance.create(:genericName => 'Makkarat', :huslab_id=>1, :substanceType => 'Kitti')
s3 = Substance.create(:genericName => 'Muut', :huslab_id=>1, :substanceType => 'Muu')

Generator.create(:batchNumber => 1234, :substance_id => 1)
Kit.create(:batchNumber => 1235, :substance_id => 2)
Other.create(:batchNumber => 1236, :substance_id => 3)

Hasstoragelocation.create(:batch_id => 1, :storagelocation_id => 1, :amount => 6, :batchType => 'Generaattori')
Hasstoragelocation.create(:batch_id => 2, :storagelocation_id => 1, :amount => 3, :batchType => 'Kitti')
Hasstoragelocation.create(:batch_id => 2, :storagelocation_id => 2, :amount => 3, :batchType => 'Kitti')
Hasstoragelocation.create(:batch_id => 3, :storagelocation_id => 1, :amount => 6, :batchType => 'Muu')

connection = ActiveRecord::Base.connection();
connection.execute("INSERT INTO firms_users VALUES (1,2)")

