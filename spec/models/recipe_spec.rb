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
  before { @recipe = Recipe.create(name: "Example Recipe") }
  after do
    Recipe.delete_all
    Hasrecipe.delete_all
  end
  
  subject { @recipe }

  it { should respond_to(:name) }
  it { should respond_to(:get_price) }
  it { should respond_to(:get_taxed_price) }
  it { should respond_to(:get_coveraged_price) }
  it { Recipe.should respond_to(:search) }
  it { Recipe.should respond_to(:get_tax) }
  it { Recipe.should respond_to(:set_tax) }
  
  it { should be_valid }
  
  it { should have_many(:materials) }
  it { should have_many(:hasmaterials) }
  
  it { should have_many(:hasrecipes) }
  it { should have_many(:subrecipes) }
  
  it { should have_many(:inverse_hasrecipes) }
  it { should have_many(:parent_recipes) }
  
  it { should belong_to(:bakery) }
  
  describe "when name is not present" do
    before { @recipe.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is already taken" do
    before { @recipe2 = Recipe.new(name: "Example Recipe")}
    it { @recipe2.should_not be_valid }
  end
  
  describe "when name is too short" do
    before { @recipe.name = "a" }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @recipe.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when coverage is ok" do
    before { @recipe.coverage = 2.3 }
    it { should be_valid }
  end
  
  describe "when coverage is negative" do
    before { @recipe.coverage = -2 }
    it { should_not be_valid }
  end
    
  describe "when there is circular dependency" do
    before do 
      @recipe2 = Recipe.new(name: "Example Recipe2")
      @recipe.subrecipes.push @recipe2
      @recipe2.subrecipes.push @recipe
    end
    it { @recipe2.should_not be_valid }
  end
  
  describe "when there is not circular dependency" do
    before do 
      @recipe3 = Recipe.new(name: "Example Recipe3")
      @recipe3.subrecipes.push @recipe
    end
    it { @recipe3.should be_valid }
  end
end
