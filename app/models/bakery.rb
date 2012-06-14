# == Schema Information
#
# Table name: bakeries
#
#  id          :integer         not null, primary key
#  description :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Bakery < ActiveRecord::Base
  has_one :firm, :as => :resource
  attr_accessible :description
  validates :description, presence: true, :length => { :maximum => 500 }
end
