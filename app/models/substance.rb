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

  attr_accessible :genericName, :eluateName, :huslab, :batches


end
