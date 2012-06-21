# encoding: utf-8
# == Schema Information
#
# Table name: recipes
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null

class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :materials
  belongs_to :firm

  attr_accessible :name, :price
  validates :name, presence: { :message => "Nimi on pakollinen" }, :length => { :minimum => 2, :maximum => 50, :message => "Nimen täytyy olla 2-50 merkkiä pitkä" }
  #validates_uniqueness_of :materials
  
  def save
    self.price = self.materials.sum(:price)
    super
  end
end
