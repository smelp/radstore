# encoding: utf-8
class Eluate < ActiveRecord::Base

  belongs_to :huslab

  has_many :hasothers, :foreign_key => "productID"
  has_many :others, :through => :hasothers
  has_many :hasgenerators, :foreign_key => "productID"
  has_many :generators, :through => :hasgenerators
  has_one  :storagelocation

  attr_accessible :name, :others, :generators, :huslab, :storagelocation_id

  validates :name, presence: { :message => "Nimi on pakollinen" }, :length => { :minimum => 2, :maximum => 50, :message => "Nimen täytyy olla 2-50 merkkiä pitkä" }
  
  def infoForSelectBox
    self.name
  end

  def self.find_unused
    Eluate.find_by_sql('SELECT * FROM eluates WHERE NOT EXISTS (SELECT * FROM haseluates WHERE haseluates.eluate_id = eluates.id)')
  end

end
