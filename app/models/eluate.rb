# encoding: utf-8
class Eluate < ActiveRecord::Base

  belongs_to :huslab

  has_many :hasothers, :foreign_key => "productID"
  has_many :others, :through => :hasothers
  has_many :hasgenerators, :foreign_key => "productID"
  has_many :generators, :through => :hasgenerators
  belongs_to  :storagelocation

  attr_accessible :name, :others, :generators, :huslab, :storagelocation_id, :storagelocation, :radioactivity, :volume

  validates :name, presence: { :message => "Nimi on pakollinen" }, :length => { :minimum => 2, :maximum => 50, :message => "Nimen täytyy olla 2-50 merkkiä pitkä" }
  
  def infoForSelectBox
    self.name
  end

  def created
    @event = Event.find_by_target_id_and_event_type(self.id, Event::NEW_ELUATE)
    @event.user_timestamp
  end

end
