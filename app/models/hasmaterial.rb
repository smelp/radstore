# encoding: utf-8
class Hasmaterial < ActiveRecord::Base
  
  belongs_to :recipe
  belongs_to :material
  
  attr_accessible :amount, :material_id, :recipe_id
  
  validates :amount, presence: { :message => "Määrä on pakollinen" }
  validates_numericality_of :amount, { :greater_than_or_equal_to => 0, :message => "Hinnan täytyy olla positiivinen numero!" }
  
end
