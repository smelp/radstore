# encoding: utf-8
class Hasstoragelocation < ActiveRecord::Base

  belongs_to :batch
  belongs_to :storagelocation


  attr_accessible :storagelocation_id, :batch_id, :amount, :batchType

  def storageName
    Storagelocation.find_by_id(self.storagelocation.id).name
  end

  def infoForSelectBox
    self.batch.batchNumber+' '+self.batch.substance.genericName+' '+self.storagelocation.name+' Käytettävissä: '+self.amount.to_s
  end

end
