# encoding: utf-8
class Radiomedicine < ActiveRecord::Base

  belongs_to :huslab
  has_many :hasothers, :foreign_key => 'productID'
  has_many :others, :through => :hasothers
  has_many :hasgenerators, :foreign_key => 'productID'
  has_many :generators, :through => :hasgenerators
  has_many :haskits, :foreign_key => 'productID'
  has_many :kits, :through => :haskits
  has_many :haseluates
  has_many :eluates, :through => :haseluates
  has_many :hasstoragelocations, :foreign_key => 'item_id'
  has_many :storagelocations,  :through => :hasstoragelocations

  attr_accessible :name, :others, :generators, :kits, :huslab, :eluates

  validates :name, presence: { :message => "Nimi on pakollinen" }, :length => { :minimum => 1, :maximum => 50, :message => "Nimen täytyy olla 1-50 merkkiä pitkä" }

end
