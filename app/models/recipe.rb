# == Schema Information
#
# Table name: recipes
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :materials
  belongs_to :firm

  attr_accessible :name
  validates :name, presence: true, :length => { :maximum => 50 }
  #validates_uniqueness_of :materials
end