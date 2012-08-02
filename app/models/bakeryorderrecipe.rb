# encoding: utf-8
class Bakeryorderrecipe < ActiveRecord::Base
  
  belongs_to :bakeryorder
  belongs_to :recipe
  
  attr_accessible :amount, :price, :recipe_id, :bakeryorder_id
  
  validates :amount, presence: { :message => "Määrä on pakollinen" }
  validates :price, presence: { :message => "Hinta on pakollinen" }
  validates_numericality_of :amount, { :greater_than_or_equal_to => 0, :message => "Määrän täytyy olla positiivinen numero!" }
  validates_numericality_of :price, { :greater_than_or_equal_to => 0, :message => "Hinnan täytyy olla positiivinen numero!" }
  
end
