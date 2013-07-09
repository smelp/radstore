class Event < ActiveRecord::Base

  attr_accessible :target_id, :event_type, :signature, :user_timestamp, :info

  NEW_BATCH = 1
  ADD_TO_BATCH = 2
  MODIFY_BATCH = 3
  REMOVE_FROM_BATCH = 4
  QUALITY_CHECK_OK = 5
  QUALITY_CHECK_NOK = 6

  NEW_ELUATE = 11
  MODIFY_ELUATE = 13
  REMOVE_ELUATE = 14

  NEW_RADIOMEDICINE = 21
  MODIFY_RADIOMEDICINE = 23
  REMOVE__RADIOMEDICINE = 24

end
