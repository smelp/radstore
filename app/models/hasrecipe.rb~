# encoding: utf-8
class Hasrecipe < ActiveRecord::Base
  
  belongs_to :recipe
  belongs_to :subrecipe, :class_name => "Recipe"
  
  attr_accessible :amount, :recipe_id, :subrecipe_id
  
  validates :amount, presence: { :message => "Määrä on pakollinen" }
  validates_numericality_of :amount, { :greater_than_or_equal_to => 0, :message => "Määrän täytyy olla positiivinen numero!" }
  
end
