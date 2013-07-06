class Haseluate < ActiveRecord::Base

  belongs_to :eluate
  belongs_to :radiomedicine

  attr_accessible :eluate_id, :radiomedicine_id
end
