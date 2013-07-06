# encoding: utf-8
# == Schema Information
#
# Table name: substances
#
#  id         :integer         not null, primary key
#
#
class Substance < ActiveRecord::Base

  belongs_to :huslab
  has_many :batches

  attr_accessible :genericName, :eluateName, :huslab, :batches, :substanceType, :huslab_id


  def batchCount
    count = 0
    self.batches.each do |batch|
      count += batch.amount
    end
    count
  end

  def getAllGenerators
    generators = Substance.find_all_by_type(1)
  end

  def getAllOthers
    others = Substance.find_all_by_type(2)
  end

  def getAllKits
    kits = Substance.find_all_by_type(3)
  end

end
