# == Schema Information
#
# Table name: firms
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  corporate_id  :string(255)
#  location      :string(255)
#  resource_id   :integer
#  resource_type :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe Firm do

  before do 
    @firm = Firm.new(name: "Example Firm", corporate_id: "1234567-8", location:"Helsinki")
    bakery = Bakery.new(description: "sample description")
    @firm.resource = bakery
  end
  
  subject { @firm }

  it { should respond_to(:name) }
  it { should respond_to(:corporate_id) }
  it { should respond_to(:location) }
  
  it { should be_valid }

  describe "when name is not present" do
    before { @firm.name = nil }
    it { should_not be_valid }
  end
  
  describe "when resource_type is not present" do
    before { @firm.resource_type = nil }
    it { should_not be_valid }
  end
  
  describe "when corporate_id is not present" do
    before { @firm.corporate_id = nil }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @firm.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when location is too long" do
    before { @firm.location = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when resource_type is invalid" do
    before { @firm.resource_type = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when resource_type is valid" do
    before { @firm.resource_type = "Bakery" }
    it { should be_valid }
  end
  
  describe "when corporate_id format is invalid" do
    it "should be invalid" do
      ids = %w[123 1234567.2
                     123456-7 12345678-9]
      ids.each do |invalid_id|
        @firm.corporate_id = invalid_id
        @firm.should_not be_valid
      end      
    end
  end

  describe "when corporate_id format is valid" do
    it "should be valid" do
      ids = %w[1234567-8]
      ids.each do |valid_id|
        @firm.corporate_id = valid_id
        @firm.should be_valid
      end      
    end
  end
end
