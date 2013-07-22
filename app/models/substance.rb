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

  attr_accessible :genericName, :eluateName, :huslab, :batches, :substanceType, :huslab_id, :supplier, :manufacturer

  BATCH = 'Erä'
  ELUATE = 'Eluaatti'
  RADIOMEDICINE = 'Radiolääke'

  GENERATOR = 'Generaattori'
  KIT = 'Kitti'
  OTHER = 'Muu'

  def batchCount
    count = 0
    self.batches.each do |batch|
      count += batch.amount
    end
    count
  end


end
