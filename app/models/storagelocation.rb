class Storagelocation < ActiveRecord::Base

  belongs_to :huslab
  has_many :hasstoragelocations
  has_many :batches, :through => :hasstoragelocations
  has_many :eluates, :through => :hasstoragelocations
  has_many :radiomedicines, :through => :hasstoragelocations

  attr_accessible :name, :info, :huslab_id

end
