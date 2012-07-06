# encoding: utf-8
require 'spec_helper'

describe Client do
  before { @client = Client.create(name: "Example Client") }
  after { Client.delete_all }

  subject { @client }

  it { should respond_to(:name) }
  it { should respond_to(:address) }
  it { should respond_to(:city) }
  it { should respond_to(:phone) }
  
  it { should be_valid }
  
  it { should belong_to(:firm) }
  
  describe "when name is not present" do
    before { @client.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is already taken" do
    before { @client2 = Client.new(name: "Example Client") }
    it { @client2.should_not be_valid }
  end
  
  describe "when name is too short" do
    before { @client.name = "a" }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @client.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when address is not present" do
    before { @client.address = " " }
    it { should_not be_valid }
  end
  
  describe "when address is too short" do
    before { @client.address = "a" }
    it { should_not be_valid }
  end
  
  describe "when address is too long" do
    before { @client.address = "a" * 81 }
    it { should_not be_valid }
  end
  
  describe "when city is not present" do
    before { @client.city = " " }
    it { should_not be_valid }
  end
  
  describe "when city is too short" do
    before { @client.city = "a" }
    it { should_not be_valid }
  end
  
  describe "when city is too long" do
    before { @client.city = "a" * 81 }
    it { should_not be_valid }
  end
  
  describe "when phonenumber is not present" do
    before { @client.phone = " " }
    it { should_not be_valid }
  end
  
  describe "when phonenumber is too short" do
    before { @client.phone = "1" }
    it { should_not be_valid }
  end
  
  describe "when phonenumber is too long" do
    before { @client.phone = "1" * 31 }
    it { should_not be_valid }
  end
    
end
