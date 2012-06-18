# == Schema Information
#
# Table name: materials
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

# encoding: utf-8
require 'spec_helper'

describe Recipe do
  before { @material = Material.new(name: "Example Material") }

  subject { @material }

  it { should respond_to(:name) }
  
  it { should be_valid }
  
  it { should have_and_belong_to_many(:recipes) }
  
  describe "when name is not present" do
    before { @material.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @material.name = "a" * 51 }
    it { should_not be_valid }
  end
  
end
