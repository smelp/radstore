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

  BATCH = 50
  ELUATE = 60
  RADIOMEDICINE = 70

  GENERATOR = 51
  KIT = 52
  OTHER = 53

  def batchCount
    count = 0
    self.batches.each do |batch|
      count += batch.amount
    end
    count
  end

  def myType
    if self.substanceType == Substance::GENERATOR
      'Generaattori'
    elsif self.substanceType == Substance::KIT
      'Kitti'
    else
      'Muu'
    end
  end

end
