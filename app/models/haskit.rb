class Haskit < ActiveRecord::Base

  belongs_to :radiomedicine
  belongs_to :kit, :foreign_key => 'kitID'

  attr_accessible :productID, :kitID, :ownerType, :amount, :volume, :fromStorage

end
