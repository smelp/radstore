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
  it { should respond_to(:price) }
  
  it { should be_valid }
  
  it { should have_many(:materials) }
  it { should have_many(:hasmaterials) }
  it { should belong_to(:firm) }
  
  describe "when name is not present" do
    before { @recipe.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too short" do
    before { @recipe.name = "a" }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @recipe.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when price is ok" do
    before { @recipe.price = 2.3 }
    it { should be_valid }
  end
  
  describe "when price is negative" do
    before { @recipe.price = -2 }
    it { should_not be_valid }
  end
  
end
