# encoding: utf-8
class Batch < ActiveRecord::Base

  belongs_to :substance
  has_many :hasstoragelocations
  has_many :storagelocations, :through => :hasstoragelocations
  has_many :events, :foreign_key => 'target_id'

  attr_accessible :batchNumber, :substance_id, :qualityControl, :storagelocations, :expDate, :hasstoragelocations, :events

  validates :batchNumber, presence: { :message => 'Eränumero on pakollinen!' }
  
  def infoForSelectBox
    self.substance.generic_name + ' Eränumero: ' + self.batchNumber.to_s() + ' Määrä: ' + self.amount.to_s()
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
    Event.where('"target_id"='+self.id+' AND ("event_type" = 1 OR "event_type" = 2')
  end

  def storageComment
    Event.find_by_target_id_and_event_type(self.id, Event::STORAGE_COMMENT)
  end

end
