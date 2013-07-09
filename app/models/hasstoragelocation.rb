class Hasstoragelocation < ActiveRecord::Base

  belongs_to :batch
  belongs_to :eluate
  belongs_to :radiomedicine
  belongs_to :storagelocation


  attr_accessible :storagelocation_id, :item_id, :amount, :item_type

end
