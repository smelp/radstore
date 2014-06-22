# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)


huslab = Firm.create(:name => 'HUSLAB', :corporate_id =>'1234567-8', :location=>'Helsinki', :address=>'Helsingintie 1', :account_number =>'11111-11111', :resource_type=>'Huslab', :resource_id=>1)

Huslab.create(:description => 'Labra', :firm => huslab)

User.create(:name =>'AdminTestaaja', :email =>'AdminTestaaja@hus.fi', :password =>'123456',:password_confirmation =>'123456',:admin => 't',:primary_firm_id => 1)

User.create(:name =>'Testaaja', :email =>'Testaaja@hus.fi', :password =>'123456',:password_confirmation =>'123456',:primary_firm_id => 1)

Storagelocation.create(:name => 'Alakerran kuumalabra', :huslab_id => 1)

#Substance.create(:generic_name => '99mTc-generaattori', :product_name => '99mTc-generaattori', :manufacturer => 'Mallinckrodt 21,5 GBq',:supplier => 'Covidien', :huslab_id=>1, :substanceType => 'Generaattori', :half_life => '10', :alert_amount => 5, :alert_days => 3)
#Substance.create(:generic_name => '99mTc-generaattori MAP', :product_name => '99mTc-generaattori MAP', :manufacturer => 'MAP',:huslab_id=>1, :substanceType => 'Generaattori', :half_life => '10', :alert_amount => 5, :alert_days => 3)

#Substance.create(:generic_name => '99mTc-Sestamibi', :product_name => '99mTc-Sestamibi', :manufacturer => 'Mallinckrodt',:supplier => 'Covidien',:huslab_id=>1, :substanceType => 'Kitti', :alert_amount => 5, :alert_days => 3)
#Substance.create(:generic_name => '99mTc-Human Albumin Macro Aggregates', :product_name => 'TechneScan LyoMAA', :manufacturer => 'Mallinckrodt Medical B.V. Holland',:supplier => 'Covidien',:huslab_id=>1, :substanceType => 'Kitti', :alert_amount => 5, :alert_days => 3)

#Substance.create(:generic_name => '0,9 % NaCl injektioneste', :product_name => '0,9 % NaCl injektioneste', :manufacturer => 'Braun',:huslab_id=>1, :substanceType => 'Muu', :alert_amount => 2)
#Substance.create(:generic_name => 'Tyhja vakuumipullo', :product_name => 'MAP generaattorin tyhja vakuumipullo', :supplier => 'MAP' ,:huslab_id=>1, :substanceType => 'Muu', :alert_amount => 2)

#Generator.create(:batchNumber => 1234, :substance_id => 1, :expDate => '2013-08-31')
#Kit.create(:batchNumber => 1235, :substance_id => 3, :expDate => '2013-08-31')
#Other.create(:batchNumber => 1236, :substance_id => 5, :expDate => '2013-08-31')

#Event.create(:target_id => 1, :event_type => 30,:user_timestamp => '2013-07-31', :signature => 'SYSTEM', :info => '')
#Event.create(:target_id => 2, :event_type => 30,:user_timestamp => '2013-07-31', :signature => 'SYSTEM', :info => '')
#Event.create(:target_id => 3, :event_type => 30,:user_timestamp => '2013-07-31', :signature => 'SYSTEM', :info => '')

#Hasstoragelocation.create(:batch_id => 1, :storagelocation_id => 1, :amount => 3, :batchType => 'Generaattori')
#Hasstoragelocation.create(:batch_id => 2, :storagelocation_id => 1, :amount => 3, :batchType => 'Kitti')
#Hasstoragelocation.create(:batch_id => 3, :storagelocation_id => 1, :amount => 3, :batchType => 'Muu')

connection = ActiveRecord::Base.connection();
connection.execute("INSERT INTO firms_users VALUES (1,2)")
connection.execute("INSERT INTO firms_users VALUES (1,1)")
