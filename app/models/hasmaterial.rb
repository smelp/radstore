class Hasmaterial < ActiveRecord::Base
  
  belongs_to :recipe
  belongs_to :material
  
  attr_accessible :amount, :material_id, :recipe_id
  
  #validates :amount, presence => { :message => "Määrä on pakollinen" }
  #validates_numericality_of :amount, :message => "Määrän täytyy olla numero!"
  
end
