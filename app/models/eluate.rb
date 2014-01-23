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

  #This is because Rails does not do composite foreign keys and hasothers table can have nonunique product_ids
  def getOthers
    Batch.find_by_sql("SELECT \"batches\".* FROM \"batches\" INNER JOIN \"hasothers\" ON \"batches\".\"id\" = \"hasothers\".\"otherID\" WHERE \"hasothers\".\"ownerType\" = 'Eluaatti' AND \"hasothers\".\"productID\" = " + self.id.to_s)
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
    decayConst = self.generators[0].substance.half_life.gsub(',','.')
    actNow = self.radioactivity.to_f*(2.718282**(-decayConst.to_f*timeDiff))
    concentrat = actNow / self.volume.gsub(',','.').to_f
    concentrat.round(3)
  end

  def self.todays
    Eluate.joins(:events).where("\"events\".\"event_type\" = 11 AND \"events\".\"user_timestamp\" BETWEEN '"+Time.now.to_date.to_s+"' AND '"+(Time.now+1.days).to_date.to_s+"'")
  end

  def self.weekOld
    Eluate.joins(:events).where("\"events\".\"event_type\" = 11 AND \"events\".\"user_timestamp\" BETWEEN '"+(Time.now-7.days).to_date.to_s+"' AND '"+(Time.now+1.days).to_date.to_s+"'").order("user_timestamp DESC")
  end


end
