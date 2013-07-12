# encoding: utf-8
class Batch < ActiveRecord::Base
  belongs_to :substance
  has_many :hasstoragelocations
  has_many :storagelocations,  :through => :hasstoragelocations

  attr_accessible :batchNumber, :substance_id, :qualityControl, :storagelocations, :expDate

  def infoForSelectBox
    self.substance.genericName + ' Eränumero: ' + self.batchNumber.to_s() + ' Määrä: ' + self.amount.to_s()
  end

  def amount
    Hasstoragelocation.where(:batch_id => self.id).sum(:amount)
  end

  def qualityStatus
    if self.qualityControl == Event::QUALITY_CHECK_OK
      'OK'
    elsif self.qualityControl == Event::QUALITY_CHECK_NOK
      'Ei OK'
    else
      'Ei suoritettu'
    end
  end

  def getEvents
    Event.where('target_id='+self.id+' AND event_type < 7')
  end

  def batchType
    self.substance.myType
  end

end
