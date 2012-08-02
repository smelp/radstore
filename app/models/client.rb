# encoding: utf-8
class Client < ActiveRecord::Base

  belongs_to :firm
  has_many :bills
  has_many :orders
    
  attr_accessible :name, :address, :phone, :city
  
  validates :name, presence: { :message => "Nimi on pakollinen" }, :length => { :minimum => 2, :maximum => 50, :message => "Nimen pituus 2-50 merkkiä" }, :uniqueness => { :message => "Asiakas on jo olemassa" } 
  validates :address, presence: { :message => "Osoite on pakollinen" }, :length => { :minimum => 2, :maximum => 80, :message => "Osoitteen pituus 2-80 merkkiä" }
  validates :city, presence: { :message => "Kaupunki on pakollinen" }, :length => { :minimum => 2, :maximum => 80, :message => "Kaupungin nimen pituus 2-80 merkkiä" }
  validates :phone, presence: { :message => "Puhelinnumero on pakollinen" }, :length => { :minimum => 6, :maximum => 30, :message => "Puhelinnumeron pituus 6-30 merkkiä" }
  
end
