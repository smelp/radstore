class Hasother < ActiveRecord::Base

  belongs_to :radiomedicine
  belongs_to :eluate
  belongs_to :other, :foreign_key => 'otherID'

  attr_accessible :productID, :otherID, :ownerType, :amount, :volume, :fromStorage

end
