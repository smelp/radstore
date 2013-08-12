# encoding: utf-8
class Radiomedicine < ActiveRecord::Base

  belongs_to :huslab

  has_many :hasothers, :foreign_key => 'productID'
  has_many :others, :through => :hasothers
  has_many :haskits, :foreign_key => 'productID'
  has_many :kits, :through => :haskits
  belongs_to  :storagelocation #was has_one before
  belongs_to  :eluate

  attr_accessible :name, :others, :kits, :huslab, :storagelocation_id, :storagelocation, :eluate, :eluate_id, :radioactivity, :volume

  validates :name, presence: { :message => "Nimi on pakollinen" }, :length => { :minimum => 1, :maximum => 50, :message => "Nimen täytyy olla 1-50 merkkiä pitkä" }

  def created
    @event = Event.find_by_target_id_and_event_type(self.id, Event::NEW_RADIOMEDICINE)
    @event.user_timestamp
  end

  def creator
    @event = Event.find_by_target_id_and_event_type(self.id, Event::NEW_RADIOMEDICINE)
    @event.signature
  end

  def calc
    timeDiff = ((Time.now - self.created) / 1.hour)
    actNow = self.radioactivity.to_f*(2.718282**(-0.1151*timeDiff))
    concetrat = actNow / self.volume.to_f
  end

end
