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
  
  @@tax = 0.13
  has_many :hasmaterials
  has_many :materials, :through => :hasmaterials
  
  #recipe-recipe association
  has_many :hasrecipes
  has_many :subrecipes, :through => :hasrecipes
  
  has_many :inverse_hasrecipes, :class_name => "Hasrecipe", :foreign_key => "subrecipe_id"
  has_many :parent_recipes, :through => :inverse_hasrecipes, :source => :recipe
  
  belongs_to :bakery
  
  attr_accessible :name, :price, :bakery
  validates :name, presence: { :message => "Nimi on pakollinen" }, :length => { :minimum => 2, :maximum => 50, :message => "Nimen täytyy olla 2-50 merkkiä pitkä" }, :uniqueness => { :message => "Reseptin nimi on jo käytössä" }
  validates_numericality_of :price, { :greater_than_or_equal_to => 0, :message => "Hinnan täytyy olla positiivinen numero!" }
  
  def get_price
    price = 0
    self.hasmaterials.each do |material|
      temp_price = Material.find(material.material_id).price
      price += (material.amount/1000 * temp_price)
    end
    
    self.subrecipes.each do |subrecipe|
      amount = self.hasrecipes.find_by_subrecipe_id(subrecipe.id).amount
      price += subrecipe.get_price * amount
    end
    price
  end
  
  def get_taxed_price
    price = self.get_price
    price + (@@tax * price)
  end
  
  def subrecipes_sum
    price_sum = amount_sum = 0
    self.subrecipes.each do |subrecipe|
      amount = self.hasrecipes.find_by_subrecipe_id(subrecipe.id).amount 
      price_sum += subrecipe.get_price * amount
      amount_sum += amount * subrecipe.materials.sum(:amount)
    end
    return price_sum, amount_sum
  end
  
  def self.search(search, page)
    paginate :per_page => 15, :page => page,
           :conditions => ['name like ?', "%#{search}%"],
           :order => 'name'
  end
end
