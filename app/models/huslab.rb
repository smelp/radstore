# encoding: utf-8

# == Schema Information
#
# Table name: bakeries
#
#  id          :integer         not null, primary key
#  description :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Huslab < ActiveRecord::Base
  has_one :firm, :as => :resource
  has_many :eluates
  has_many :substances
  has_many :radiomedicines
  has_many :storagelocations
  
  attr_accessible :description, :firm
  
  validates :description, presence: { :message => "Kuvaus on pakollinen" }, :length => { :maximum => 500, :message => "Kuvaus voi olla enintään 500 merkkiä pitkä" }
  
  # def get_orders
  #   list = []
  #   self.bakeryorders.each do |o|
  #     if o.order.bill
  #       #nop
  #     else
  #       list.push o.order
  #     end
  #   end
  #   list
  # end
  
  # def get_product_list
  #   self.recipes.find(:all, :conditions => { :product => true })
  # end
end
