# encoding: utf-8
class Eluate < ActiveRecord::Base

  belongs_to :huslab
  has_many :radiomedicines
  has_many :hasothers, :foreign_key => "productID"
  has_many :others, :through => :hasothers
  has_many :hasgenerators, :foreign_key => "productID"
  has_many :generators, :through => :hasgenerators
  has_many :events,:foreign_key => "target_id"
  belongs_to  :storagelocation

  attr_accessible :name, :others, :generators, :huslab, :storagelocation_id, :storagelocation, :volume, :radioactivity, :radiomedicines

  validates :name, presence: { :message => "Nimi on pakollinen" }
  
  def infoForSelectBox
    self.name
  end

  def created
    @event = Event.find_by_target_id_and_event_type(self.id, Event::NEW_ELUATE)
    @event.user_timestamp
  end

  def creator
    @event = Event.find_by_target_id_and_event_type(self.id, Event::NEW_ELUATE)
    @event.signature
  end

  def calc
    timeDiff = ((Time.now - self.created) / 1.hour)
    actNow = self.radioactivity.to_f*(2.718282**(-0.1151*timeDiff))
    concetrat = actNow / self.volume.to_f
    concetrat.round(3)
  end

  def self.todays
    Eluate.joins(:events).where("\"events\".\"event_type\" = 11 AND \"events\".\"user_timestamp\" BETWEEN '"+Time.now.to_date.to_s+"' AND '"+(Time.now+1.days).to_date.to_s+"'")
  end

end
