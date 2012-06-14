# == Schema Information
#
# Table name: bakeries
#
#  id          :integer         not null, primary key
#  description :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Bakery do
  before { @bakery = Bakery.new(description: "this is sample description") }
  
  subject { @bakery }

  it { should respond_to(:description) }
  
  it { should be_valid }

  describe "when description is not present" do
    before { @bakery.description = nil }
    it { should_not be_valid }
  end
  
  describe "when description is too long" do
    before { @bakery.description = "a" * 501 }
    it { should_not be_valid }
  end
end
