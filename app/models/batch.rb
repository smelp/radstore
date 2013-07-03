class Batch < ActiveRecord::Base
  belongs_to :substance

  attr_accessible :batchNumber, :amount
end
