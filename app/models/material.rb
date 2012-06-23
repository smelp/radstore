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
  belongs_to :firm
    
  attr_accessible :name, :firm, :price, :recipes
  
  validates :name, presence: { :message => "Nimi on pakollinen" }, :length => { :maximum => 50, :message => "Nimen pituus 5-50 merkkiä" } 
  validates :price, presence: { :message => "Hinta on pakollinen" }
  validates_numericality_of :price, :message => "Hinnan täytyy olla numero!"
  
end
