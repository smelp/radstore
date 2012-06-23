class Hasmaterial < ActiveRecord::Base
  
  belongs_to :recipes
  belongs_to :materials
  
  attr_accessible :amount
  
  #validates :amount, presence => { :message => "Määrä on pakollinen" }
  #validates_numericality_of :amount, :message => "Määrän täytyy olla numero!"
  
end
