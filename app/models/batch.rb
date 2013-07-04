# encoding: utf-8
class Batch < ActiveRecord::Base
  belongs_to :substance

  attr_accessible :batchNumber, :amount

  def infoForSelectBox
    self.substance.genericName + ' Eränumero: ' + self.batchNumber.to_s() + ' Määrä: ' + self.amount.to_s()
  end

end
