# == Schema Information
#
# Table name: recipes
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

# encoding: utf-8
require 'spec_helper'

describe Recipe do
  before { @recipe = Recipe.new(name: "Example Recipe") }

  subject { @recipe }

  it { should respond_to(:name) }
  
  it { should be_valid }
  
  it { should have_and_belong_to_many(:materials) }
  it { should have_and_belong_to_many(:firms) }
  
  describe "when name is not present" do
    before { @recipe.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @recipe.name = "a" * 51 }
    it { should_not be_valid }
  end
  
end
