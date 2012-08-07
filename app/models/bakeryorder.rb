# encoding: utf-8
class Bakeryorder < ActiveRecord::Base
  has_one :order, :as => :suborder

  belongs_to :bakery
  has_many :recipes, :through => :bakeryorderrecipes
  has_many :bakeryorderrecipes
  
  attr_accessible :order, :state, :delivery_type
  
  delivery_list = ["Posti", "Nouto"]
  state_list = ["Tilattu", "Tehty", "Laskutettu", "Maksettu", "Kirjattu"]
  validates :delivery_type, presence: { :message => "Toimitustapa on pakollinen" }
  validates_inclusion_of :delivery_type, :in => delivery_list, :allow_nil => false, :message => "Toimitustavan täytyy olla joku seuraavista: #{delivery_list}"
  validates :order, presence: { :message => "Tilauksen ylityyppi pitää olla määritetty." }
  validates :bakery, presence: { :message => "Leipomofirma pitää olla määritetty." }
  
  validates_inclusion_of :state, :in => state_list, :allow_nil => false, :message => "Tilan täytyy olla joku seuraavista: #{state_list}"

  def self.get_delivery_types
    ["Posti", "Nouto"] 
  end
  
  def self.get_state_list
    ["Tilattu", "Tehty", "Laskutettu", "Maksettu", "Kirjattu"]
  end
  
  def get_total_amount
    amount = 0
    self.bakeryorderrecipes.each do |b|
      amount += b.price
    end
    amount
  end
  
end
