# encoding: utf-8
class Bakerybill < ActiveRecord::Base
  has_one :bill, :as => :subbill

  attr_accessible :bill, :recipe, :bakery, :client
  
  belongs_to :bakery
  has_many :recipes, :through => :billrecipes
  has_many :billrecipes
  
  validates :bill, presence: { :message => "Reseptilaskun ylityyppi pitää olla määritetty." }
  validates :bakery, presence: { :message => "Leipomofirma pitää olla määritetty." }
end
