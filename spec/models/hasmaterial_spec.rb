# encoding: utf-8

require 'spec_helper'

describe Hasmaterial do
  before do 
    @material = Material.create(name: "Test Material", price: 2.0)
    @recipe = Recipe.create(name: "Example Recipe")
    @hasmaterial = Hasmaterial.new(material_id: @material.id, recipe_id: @recipe.id, amount:1000)
  end
  
  after do
    Material.destroy_all
    Recipe.destroy_all
    Hasmaterial.destroy_all
  end

  subject { @hasmaterial }

  it { should respond_to(:amount) }
  it { should respond_to(:material_id) }
  it { should respond_to(:recipe_id) }
  
  it { should be_valid }
  
  it { should belong_to(:recipe) }
  it { should belong_to(:material) }
  
  describe "when amount is not present" do
    before { @hasmaterial.amount = " " }
    it { should_not be_valid }
  end
  
  describe "when amount is negative" do
    before { @hasmaterial.amount = -2 }
    it { should_not be_valid }
  end
  
  describe "when amount is not numeric" do
    before { @hasmaterial.amount = "asda " }
    it { should_not be_valid }
  end
  
end
