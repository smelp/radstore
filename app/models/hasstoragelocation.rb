class Hasstoragelocation < ActiveRecord::Base

  belongs_to :batch
  belongs_to :storagelocation


  attr_accessible :storagelocation_id, :batch_id, :amount

  def storageName
    Storagelocation.find_by_id(self.storagelocation.id).name
  end

end
