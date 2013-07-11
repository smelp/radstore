# encoding: utf-8
class Radiomedicine < ActiveRecord::Base

  belongs_to :huslab
  has_many :hasothers, :foreign_key => 'productID'
  has_many :others, :through => :hasothers
  has_many :hasgenerators, :foreign_key => 'productID'
  has_many :generators, :through => :hasgenerators
  has_many :haskits, :foreign_key => 'productID'
  has_many :kits, :through => :haskits
  has_one  :storagelocation

  attr_accessible :name, :others, :generators, :kits, :huslab, :storagelocation_id, :storagelocation

  validates :name, presence: { :message => "Nimi on pakollinen" }, :length => { :minimum => 1, :maximum => 50, :message => "Nimen täytyy olla 1-50 merkkiä pitkä" }

  def eluates
    Eluate.find_all_by_radiomedicine_id(self.id)
  end

  def created
    @event = Event.find_by_target_id_and_event_type(self.id, Event::NEW_RADIOMEDICINE)
    @event.user_timestamp
  end

end
