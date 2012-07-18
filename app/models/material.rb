# encoding: utf-8
# == Schema Information
#
# Table name: materials
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Material < ActiveRecord::Base
  has_many :hasmaterials
  has_many :recipes, :through => :hasmaterials
  belongs_to :bakery
    
  attr_accessible :name, :bakery, :price
  
  validates :name, presence: { :message => "Nimi on pakollinen" }, :length => { :minimum => 2, :maximum => 50, :message => "Nimen pituus 2-50 merkkiä" } 
  validates :price, presence: { :message => "Hinta on pakollinen" }
  validates_numericality_of :price, { :greater_than_or_equal_to => 0, :less_than => 100000000, :message => "Hinnan täytyy olla positiivinen numero välillä 0 - 100.000.000!" }
  
end
