class Hasgenerator < ActiveRecord::Base

  belongs_to :radiomedicine
  belongs_to :eluate
  belongs_to :generator, :foreign_key => 'generatorID'

  attr_accessible :productID, :generatorID, :ownerType


end
