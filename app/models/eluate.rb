# encoding: utf-8
class Eluate < ActiveRecord::Base

  belongs_to :huslab

  has_many :hasothers, :foreign_key => "productID"
  has_many :others, :through => :hasothers
  has_many :hasgenerators, :foreign_key => "productID"
  has_many :generators, :through => :hasgenerators
  belongs_to  :storagelocation
  belongs_to  :radiomedicine

  attr_accessible :name, :others, :generators, :huslab, :storagelocation_id, :radiomedicine

  validates :name, presence: { :message => "Nimi on pakollinen" }, :length => { :minimum => 2, :maximum => 50, :message => "Nimen täytyy olla 2-50 merkkiä pitkä" }
  
  def infoForSelectBox
    self.name
  end

  def self.find_unused
    Eluate.find_by_sql('SELECT * FROM eluates WHERE radiomedicine_id IS NULL')
  end

end
