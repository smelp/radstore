class Eluate < ActiveRecord::Base

  belongs_to :huslab
  has_many :hasothers, :foreign_key => "productID"
  has_many :others, :through => :hasothers
  has_many :hasgenerators, :foreign_key => "productID"
  has_many :generators, :through => :hasgenerators

  attr_accessible :name, :others, :generators, :huslab

end
