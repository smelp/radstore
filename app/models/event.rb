# encoding: utf-8
class Event < ActiveRecord::Base

  attr_accessible :target_id, :event_type, :signature, :user_timestamp, :info

  validates :signature, presence: { :message => "Nimikirjaimet puuttuvat!" }
  validates :user_timestamp, presence: { :message => "Kirjauspäivä on pakollinen" }

  NEW_BATCH = 1
  ADD_TO_BATCH = 2
  MODIFY_BATCH = 3
  REMOVE_FROM_BATCH = 4
  QUALITY_CHECK_OK = 5
  QUALITY_CHECK_NOK = 6
  QUALITY_CHECK_NOT_DONE = 7

  NEW_ELUATE = 11
  ELUATE_MODIFIED = 13
  ELUATE_REMOVED = 14

  NEW_RADIOMEDICINE = 21
  RADIOMEDICINE_MODIFIED = 23
  RADIOMEDICINE_REMOVED = 24

  STORAGE_COMMENT = 30

end
