# encoding: utf-8
class Batch < ActiveRecord::Base
  belongs_to :substance
  has_many :hasstoragelocations, :foreign_key => 'item_id'
  has_many :storagelocations,  :through => :hasstoragelocations

  attr_accessible :batchNumber, :substance_id, :qualityControl

  def infoForSelectBox
    self.substance.genericName + ' Eränumero: ' + self.batchNumber.to_s() + ' Määrä: ' + self.amount.to_s()
  end

  def amount
    Hasstoragelocation.where(:item_id => self.id, :item_type => self.substance.substanceType).sum(:amount)
  end

  def qualityStatus
    if self.qualityControl == Event::QUALITY_CHECK_OK
      'OK'
    elsif self.qualityControl == Event::QUALITY_CHECK_NOK
      'Ei OK'
    end

  end

end
