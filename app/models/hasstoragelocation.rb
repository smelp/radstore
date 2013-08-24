# encoding: utf-8
class Hasstoragelocation < ActiveRecord::Base

  belongs_to :batch
  belongs_to :storagelocation

  attr_accessible :storagelocation_id, :batch_id, :amount, :batchType, :storagelocation

  validates :amount, presence: { :message => "Määrä on pakollinen" }
  validates_numericality_of :amount, { :greater_than_or_equal_to => 0, :message => "Määrän täytyy olla positiivinen numero!" }
  
  def storageName
    Storagelocation.find_by_id(self.storagelocation.id).name
  end

  def infoForSelectBox
    qString = ''
    if self.batch.substance.substanceType == 'Kitti' && self.batch.qualityStatus == 'Ei suoritettu'
      qString = 'LAADUNVARMISTUS EI SUORITETTU!! '
    end
    qString+self.batch.batchNumber+' '+self.batch.substance.generic_name+' '+self.storagelocation.name+' Käytettävissä: '+self.amount.to_s
  end

end
